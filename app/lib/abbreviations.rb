# frozen_string_literal: true

# Abbreviations methods
module Abbreviations
  # Abbreviations
  def last_job_like_dislike_params
    {
      'ls' => 'Низкая зарплата',
      'upct' => 'Неудовлетворительный психологический климат в коллективе',
      'llbo' => 'Невысокий уровень организации дела',
      'drvm' => 'Сложные отношения с руководством',
      'ncp' => 'Нет перспективы должностного роста',
      'emr' => 'Чрезмерно высокие требования руководства',
      'ow' => 'Сверхурочная работа',
      'so' => 'Что-то другое'
    }
  end

  def work_experience_areas
    {
      'prod' => 'Производство',
      'serv' => 'Услуги',
      'whsal' => 'Оптовая торговля',
      'ret' => 'Розничная торговля',
      'publ' => 'Издательство',
      'pc' => 'Общепит',
      'build' => 'Строительство',
      'tr' => 'Транспорт',
      'ent' => 'Индивидуальный предприниматель'
    }
  end

  def desired_pay_system
    {
      'sal' => 'Оклад',
      'salbon' => 'Оклад+премия',
      'int' => 'Процент',
      'salint' => 'Оклад+процент'
    }
  end

  # Form-s helpers
  def intitalise_form_variables
    @last_job_like_dislike_params = last_job_like_dislike_params
    @work_experience_areas        = work_experience_areas
    @desired_pay_system           = desired_pay_system
    @tables_names                 = tables_names
  end
end
