import digdag
class Task(object):
  def store(self):
    digdag.env.store({'sotre_key': 'store_value'})
