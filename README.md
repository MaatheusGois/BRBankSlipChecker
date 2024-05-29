# 🇧🇷 BRBankSlipChecker

Based in: https://github.com/mcrvaz/boleto-brasileiro-validator

Biblioteca para validar boletos.

Suporta boletos de arrecadação e boletos bancários, tanto a representação do código de barras como a linha digitável.

**Todas as validações podem ser feitas com ou sem máscara.**

## Exemplos de boletos

## Arrecadação
![Represetação visual do código de barras do boleto de arrecadação](https://i.imgur.com/AQmEn0S.png)
### Arrecadação - Código de barras
85890000460 52460179160 60759305086 83148300001
### Arrecadação - Linha digitável
85890000460-9 52460179160-5 60759305086-5 83148300001-0

## Bancário
![Represetação visual do código de barras do boleto bancário](https://i.imgur.com/FfCdC1Y.png)
### Bancário - Código de barras
84890000000404201622018060519042958603411122
### Bancário - Linha digitável
23793.38128 60007.827136 95000.063305 9 75520000370000

# Instalação

# Como usar
### **Para validar qualquer tipo de boleto, com ou sem máscara**
```swift
import BRBankSlipChecker

BRBankSlipChecker.validate("23793.38128 60007.827136 95000.063305 9 75520000370000") // true
BRBankSlipChecker.validate("23793381286000782713695000063305975520000370000") // true
BRBankSlipChecker.validate("836200000005 667800481000 180975657313 001589636081") // true
BRBankSlipChecker.validate("536200000005 667800481000 180975657313 001589636081") // false
BRBankSlipChecker.validate("001933737000000144816060680935031") // false
```
### **Para validar boletos de arrecadação (luz, água, etc.)**

```swift
import BRBankSlipChecker

PaymentSlip.validate("836200000005 667800481000 180975657313 001589636081") // true
PaymentSlip.paymentSlipDigitableLine("84890000000404201622018060519042958603411122") // true
PaymentSlip.paymentSlipBarcode("85890000460-9 52460179160-5 60759305086-5 83148300001-0") // true
```

### **Para validar boletos bancários**
```swift
import BRBankSlipChecker

BankSlip.validate("23793.38128 60007.827136 95000.063305 9 75520000370000") // true
BankSlip.bankSlipBarcode("00193373700000001000500940144816060680935031") // true
BankSlip.bankSlipDigitableLine("23793381286000782713695000063305975520000370000") // true

```
### **Observação**
**Por padrão, a validação individual de cada bloco não é realizada.**

Caso esse comportamento seja necessário, as seguintes funções aceitam um parâmetro adicional para habilitar a validação:
```swift
BRBankSlipChecker.validate("23793.38128 60007.827136 95000.063305 9 75520000370000", validateBlocks: true);

BankSlip.validate("23793381286000782713695000063305975520000370000", validateBlocks: true);
BankSlip.bankSlipDigitableLine("23793381286000782713695000063305975520000370000", validateBlocks: true);

PaymentSlip.validate("836200000005667800481000180975657313001589636081", validateBlocks:  true);
PaymentSlip.paymentSlipDigitableLine("836200000005667800481000180975657313001589636081", validateBlocks: true);
```

# Regras de Validação
Regras para validação de boletos bancários: [Especificações Técnicas
para Confecção de Boleto de Cobrança
do Banco do Brasil](http://www.bb.com.br/docs/pub/emp/empl/dwn/Doc5175Bloqueto.pdf)

Regras para validação de boletos de arrecadação: [FEBRABAN - "Layout" Padrão de Arrecadação/Recebimento
com Utilização do Código de Barras](https://cmsportal.febraban.org.br/Arquivos/documentos/PDF/Layout%20-%20C%C3%B3digo%20de%20Barras%20ATUALIZADO.pdf)

# Licença
This project is licensed under the MIT License - see the LICENSE.md file for details