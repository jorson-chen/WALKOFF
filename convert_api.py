import os
import yaml
import re


def convert_apis():
    for subdir, dir, files in os.walk('./apps'):
        for file in (file for file in files if file == 'api.yaml'):
            print('Processing {0}/{1}'.format(subdir, file))
            with open(os.path.join(subdir, file), 'r') as f:
                api = f.read()
                api = api.replace('externalDocs:', 'external_docs:')
                api = api.replace('termsOfService:', 'terms_of_service:')
                api = api.replace('dataIn:', 'data_in:')
                api = re.sub(r'^flags', 'conditions', api)
                api = re.sub(r'^filters', 'transforms', api)
                api_dict = yaml.load(api)
                scan_api(api_dict, subdir)
            with open(os.path.join(subdir, file), 'w') as f:
                f.write(api)


def scan_api(api, path):
    if 'transforms' in api:
        scan_transforms(api['transforms'], path)


def scan_transforms(transforms, path):
    for transform, transform_api in transforms.items():
        if 'returns' not in transform_api:
            print('Error in {0}--transforms.{1}: Transforms now require explicit returns'.format(path, transform))

if __name__ == "__main__":
    convert_apis()