output_dir := "output"

sch:
  mkdir -p {{output_dir}}
  kicad-cli sch export pdf Klask_PCB.kicad_sch -o {{output_dir}}/SCH.pdf

pcb_f:
  mkdir -p {{output_dir}}
  kicad-cli pcb export pdf -l F.Cu,F.Silkscreen,Edge.Cuts Klask_PCB.kicad_pcb -o {{output_dir}}/PCB_F.pdf

pcb_b:
  mkdir -p {{output_dir}}
  kicad-cli pcb export pdf -l B.Cu,B.Silkscreen,Edge.Cuts Klask_PCB.kicad_pcb -o {{output_dir}}/PCB_B.pdf

pcb: pcb_f pcb_b

gerbers:
  mkdir -p {{output_dir}}/gerbers
  kicad-cli pcb export gerbers Klask_PCB.kicad_pcb -o {{output_dir}}/gerbers
  kicad-cli pcb export drill Klask_PCB.kicad_pcb -o {{output_dir}}/gerbers

image_front:
  mkdir -p {{output_dir}}
  kicad-cli pcb render Klask_PCB.kicad_pcb -o {{output_dir}}/pcb_front.png --side front

image_back:
  mkdir -p {{output_dir}}
  kicad-cli pcb render Klask_PCB.kicad_pcb -o {{output_dir}}/pcb_back.png --side back

image: image_front image_back

export: sch pcb gerbers image

erc:
  mkdir -p {{output_dir}}
  kicad-cli sch erc Klask_PCB.kicad_sch --exit-code-violations -o {{output_dir}}/erc.rpt

drc:
  mkdir -p {{output_dir}}
  kicad-cli pcb drc ./Klask_PCB.kicad_pcb --exit-code-violations -o {{output_dir}}/drc.rpt

check: erc drc

