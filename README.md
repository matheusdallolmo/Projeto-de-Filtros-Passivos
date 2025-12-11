# Projeto de Filtros Passivos - Crossover de Áudio

**Autor:** Matheus Dall Olmo
**Disciplina:** Circuitos de Corrente Alternada (CC44CP) - UTFPR Pato Branco

## 1. Apresentação do Problema
Este projeto consiste no dimensionamento de um crossover passivo de duas vias (Woofer e Tweeter) para uma caixa de som. O objetivo é separar as frequências baixas para o woofer e as altas para o tweeter, garantindo fidelidade sonora utilizando filtros Butterworth de 2ª ordem.

## 2. Especificações de Projeto
* **Impedância da Carga ($R_L$):** 4 $\Omega$
* **Frequência de Corte ($f_c$):** 3.6 kHz
* **Tipo de Filtro:** Butterworth de 2ª Ordem (atenuação de -12 dB/oitava).

## 3. Metodologia e Fórmulas
Utilizou-se o MATLAB para calcular os componentes. As funções de transferência para um filtro Butterworth de 2ª ordem são:

* **Passa-Baixas (LPF):** $H(s) = \frac{\omega_c^2}{s^2 + \omega_c\sqrt{2}s + \omega_c^2}$
* **Passa-Altas (HPF):** $H(s) = \frac{s^2}{s^2 + \omega_c\sqrt{2}s + \omega_c^2}$

Os componentes ideais foram calculados pelas fórmulas:
$$L = \frac{R \sqrt{2}}{\omega_c} \quad \text{e} \quad C = \frac{1}{\omega_c R \sqrt{2}}$$

Onde $\omega_c = 2 \pi f_c$.

## 4. Como Executar
1.  Certifique-se de ter o MATLAB instalado (qualquer versão recente).
2.  Baixe o arquivo `projeto_final.m` deste repositório.
3.  Abra o arquivo no MATLAB e clique em **Run** (ou pressione F5).
4.  Os resultados numéricos aparecerão no *Command Window* e o gráfico será gerado em uma nova janela.

## 5. Resultados Obtidos

### Valores Calculados (Ideal vs. Comercial)

| Componente | Valor Ideal Calculado | Valor Comercial Escolhido | Erro (%) |
| **Indutor (L)** | 0.250088 mH | 0.27 mH | 7.96 % |
| **Capacitor (C)** | 7.815246 $\mu$F | 8.20 $\mu$F | 4.92 % |

### Gráfico de Bode
<img width="1763" height="532" alt="image" src="https://github.com/user-attachments/assets/fd23be5a-82f4-4e33-a499-6e3f08b57fa3" />

<img width="1763" height="532" alt="image" src="https://github.com/user-attachments/assets/fdb08963-c843-4f6e-9834-633d972346c1" />

## 6. Análise Crítica

A comparação entre os componentes ideais calculados e os comerciais disponíveis revelou desvios inerentes ao uso de componentes discretos padronizados.

**Impacto Prático no Sistema:**
Como a frequência de corte é inversamente proporcional aos valores de $L$ e $C$ ($f_c = \frac{1}{2\pi\sqrt{LC}}$), o aumento de ambos os componentes (escolha de valores comerciais superiores aos ideais) causou um **deslocamento da frequência de corte para baixo**.

Recalculando com os valores reais ($L=0.27\text{mH}, C=8.2\mu\text{F}$):
$$f_{real} = \frac{1}{2\pi \sqrt{0.27 \cdot 10^{-3} \cdot 8.2 \cdot 10^{-6}}} \approx 3383 \, \text{Hz}$$

Isso representa um desvio de aproximadamente **217 Hz** em relação ao objetivo de projeto ($3600 \text{ Hz}$).

**Audibilidade:**
Embora tecnicamente haja um erro, um desvio de cerca de 6% na frequência de corte é, na prática, pouco perceptível para a maioria dos ouvintes em aplicações de áudio comuns. No entanto, em sistemas de alta fidelidade (Hi-Fi), esse deslocamento poderia alterar a resposta de fase na região de cruzamento, potencialmente criando pequenos vales ou picos na resposta total da caixa de som se os transdutores não tiverem uma resposta perfeitamente linear nessa nova região de $3.3 \text{ kHz}$.

## 7. Conclusões
O projeto atingiu seu objetivo principal, permitindo o dimensionamento de um crossover passivo Butterworth de 2ª ordem funcional para uma carga de $4 \Omega$.

O maior desafio encontrado foi a limitação imposta pela disponibilidade comercial de componentes. Observou-se que os "degraus" dos valores de indutores e capacitores nem sempre permite atingir o valor matemático exato, obrigando o engenheiro a tomar decisões. No caso deste projeto, a ferramenta computacional optou pelos valores mais próximos absolutos, o que resultou em componentes ligeiramente maiores e uma frequência de corte real levemente reduzida.

Esta experiência reforça que a engenharia prática exige a capacidade de analisar tolerâncias e aceitar aproximações que mantenham o desempenho do sistema dentro de margens aceitáveis de operação e custo.
