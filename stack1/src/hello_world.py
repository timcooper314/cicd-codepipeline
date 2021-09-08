def hello_world():
    print("Hello, World!")


def lambda_handler(event, context):
    return hello_world()
