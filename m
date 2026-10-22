Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688854;
	b=XeFYNfmZCY284csIsYdku8eiw7YjbB9ftMpg3IV+BgFtMxApGpfL6Nn+bCCFM3hVtMBf
	 /9FzN68NTnUaMX5zR7blVas2rTxJOQpTBh3n0bnbH9nohRsaKyDWD/r+o8wJn+L35arQL
	 2cIsG2eXu+AkLF/GFTH2zHzoq7bd3+XUB6AGxIT40C+BYK54LJ9+XK2j+otwedmwjG8Gt
	 YkOwRYzGM5nHVJIbNnJ2AIwhDAVA9nlwAx0+bQyZF/d8hBbBtJop6hpJFOZ5MiJAlPoRK
	 GlbBcwkbJEPFBhXWBqEf9PEixBgm0dAbYOn40TdAKFyIfpNKIAvqgNGIRlzqLzBnLsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688854;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=KncKH2UewY/IQiP6GR2JSb1uHy6TFz2Qs/vbYyhK7F4=;
	b=WPWZbo8byYlWyUIxh4lKsH/tONVyi5Plk15GOSLN0B6IjkxKALK1FD/LyoafeSHMn1BK
	 oxN+auFube40dTBNZVGQkMxHerhr/Frtl831gn24o4ToAa1wKM91dYnBoQVvDxP3xxYib
	 X2FDfxzuC05qTE+CIZ21y7yGDqZ3vvEa8pP4qj+7DL+uUA9vmjqt6ksPfHgWYPhHBfuiM
	 Yjoqw+dJjFl1+1tRvyCrQZ8pzWFa+iy50MNAwXkWrcv+RswL9H/fvy/v1il1iWkGyH82Z
	 bpBLl/d/9ZVGVllkpN09yzjHp9i1wLDGX/Gq/OjC0gD4w60HsKEDdHZUxwgmiyp8IXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vinarskis.com;
	spf=pass smtp.mailfrom=vinarskis.com;
	dkim=pass header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=Xz3GQSYr;
	arc=none smtp.remote-ip=185.70.43.18
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13052606A31A;
	Thu, 22 Oct 2026 17:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13052606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=Xz3GQSYr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail3; t=1792688850; x=1792948050;
	bh=KncKH2UewY/IQiP6GR2JSb1uHy6TFz2Qs/vbYyhK7F4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Xz3GQSYrq8v4eGe62C6e13on1kSbd4fOE6dfOZbmVlk/WjJ9aAoEXYN8gxeGpoaxe
	 rQrhLSbrqx0zxSjIxTeAdW4axJGaX8ObQCqt5DHI6u4Fz8wkFW/mwV15N5ayRw5mHi
	 7Q23Zs9uM3rDSakmRbCd/Wq+gPjHonvkqyzrlY0qkdElfQKih28Y45dBN0n9Ku1/rD
	 PpcvyBJkaOtRGyWecbxprhfip0ZlY+F6YTtdvf3We82xVyQldxlzkWLoxguVN3Dbaq
	 UQMnCIPWRIxQbwL2LCzaHe7ockt9xcnFDmfbXslnuw5gKOhXhtcwYb9IBVo2GzhiVz
	 R/XKf4QSSyl4A==
Date: Thu, 22 Oct 2026 17:07:25 +0000
To: Liviu Nicoara <lnicoara@thinkoid.org>
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Michael Burch <me@michaelburch.net>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>, Tobias Heider <tobias.heider@canonical.com>, Val Packett <val@packett.cool>, Neil Armstrong <neil.armstrong@linaro.org>, Stephan Gerhold <stephan.gerhold@linaro.org>, linux-hardening@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345: introduce EC
Message-ID: <NCQ5O8k2_GpmJZBjDzgZL67uwdiYmmuSudO9VmdRaFTDq0u7aec6at00VYbzdwwSVvgJnLnGxewwp_TVO9oTjM2pAjP_LoiURf9JCIKXB-w=@vinarskis.com>
In-Reply-To: <20261013195327.19571-1-lnicoara@thinkoid.org>
References: <20261013172718.12355-1-me@michaelburch.net> <20261013195327.19571-1-lnicoara@thinkoid.org>
Feedback-ID: 158356072:user:proton
X-Pm-Message-ID: f96dfcfbbb36501a2b9c4dfd42be303868b89fe4
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 13th, 2026 at 21:53, Liviu Nicoara <lnicoara@thinkoid.o=
rg> wrote:

> On Tue, 13 Oct 2026 12:27:16 -0500, Michael Burch wrote:
> > These two should be AMUX1_GPIO and AMUX2_GPIO. My unit (BIOS 2.14.0)
> > shows what Liviu reported [1]: 0x14c (lpddr5_therm) reads 130.048 C fro=
m
> > boot on, and that is the value the EC is sent.
>=20
> Same here, and the ADC1 table settles what my readings left open.
> On this unit (also BIOS 2.14.0), with all four GPIO channels defined
> in one DTB on a 7.2.6 kernel:
>=20
> 0x14a  38.6 C        0x14c  130.0 C (constant)
> 0x14b  32.7 C        0x14d   34.7 C
>=20
> A charger on the left USB-C port warmed 0x14b by 1.6 C in three
> minutes; 0x14d stayed within 0.1 C. So usb_charger_left_therm is
> AMUX2_GPIO, 0x14b, as your table says; 0x14a reads a board
> temperature and warms with the SoC.

Hey,

Thats a very good find. I have checked and it seems you are right;
Most of mapping between ADC channels relied on schematics that I
managed to get my hands on, its now clear that it is not a most up
to date document... As EC only reacts to some of the temperatures
fed to it and not all, I missed this in my testing.

Ignoring all the information from schematics now, I am trying to
re-verify names for all the ADC channels. I do not think the left
charger you identified is correct - how did you arrive to that
conclusion? Curious to compare to my method. I run a number of
stress tests to narrow it down:

1. RHS charger getting plugged, 10s wait:
LABEL                         START        END       DIFF
pm8550_die_temp              49.5=C2=B0C     49.0=C2=B0C     -0.6=C2=B0C
vph_pwr_therm                53.3=C2=B0C     53.1=C2=B0C     -0.2=C2=B0C
usb_charger_right_therm      45.2=C2=B0C     47.5=C2=B0C     +2.3=C2=B0C
ssd_conn_therm               47.0=C2=B0C     46.6=C2=B0C     -0.4=C2=B0C
sys_therm5                   39.1=C2=B0C     39.3=C2=B0C     +0.2=C2=B0C
keyboard_therm               51.6=C2=B0C     51.3=C2=B0C     -0.3=C2=B0C
pm8550_gpio_01               51.4=C2=B0C     51.1=C2=B0C     -0.3=C2=B0C
pm8550_gpio_02               44.6=C2=B0C     44.3=C2=B0C     -0.3=C2=B0C
lpddr5_therm                130.0=C2=B0C    130.0=C2=B0C     +0.0=C2=B0C
usb_charger_left_therm       35.9=C2=B0C     35.8=C2=B0C     -0.0=C2=B0C
pm8550ve_2_die_temp          50.7=C2=B0C     50.3=C2=B0C     -0.4=C2=B0C
pmk8550_die_temp             48.1=C2=B0C     47.6=C2=B0C     -0.5=C2=B0C
pmc8380_3_die_temp           48.6=C2=B0C     48.1=C2=B0C     -0.5=C2=B0C
pmc8380_4_die_temp           47.1=C2=B0C     46.7=C2=B0C     -0.3=C2=B0C
pmc8380_5_die_temp           48.8=C2=B0C     48.3=C2=B0C     -0.5=C2=B0C
pmc8380_6_die_temp           48.0=C2=B0C     47.4=C2=B0C     -0.6=C2=B0C
pm8550ve_8_die_temp          47.3=C2=B0C     47.8=C2=B0C     +0.5=C2=B0C
pm8550ve_9_die_temp          51.3=C2=B0C     51.0=C2=B0C     -0.4=C2=B0C

Charger unplugged:
LABEL                         START        END       DIFF
pm8550_die_temp              49.3=C2=B0C     48.5=C2=B0C     -0.8=C2=B0C
vph_pwr_therm                53.0=C2=B0C     52.5=C2=B0C     -0.6=C2=B0C
usb_charger_right_therm      47.1=C2=B0C     45.7=C2=B0C     -1.4=C2=B0C
ssd_conn_therm               46.5=C2=B0C     46.1=C2=B0C     -0.4=C2=B0C
sys_therm5                   39.2=C2=B0C     39.2=C2=B0C     -0.0=C2=B0C
keyboard_therm               51.3=C2=B0C     51.0=C2=B0C     -0.3=C2=B0C
pm8550_gpio_01               51.3=C2=B0C     51.0=C2=B0C     -0.3=C2=B0C
pm8550_gpio_02               44.3=C2=B0C     44.0=C2=B0C     -0.3=C2=B0C
lpddr5_therm                130.0=C2=B0C    130.0=C2=B0C     +0.0=C2=B0C
usb_charger_left_therm       35.8=C2=B0C     35.8=C2=B0C     -0.0=C2=B0C
pm8550ve_2_die_temp          50.2=C2=B0C     49.7=C2=B0C     -0.5=C2=B0C
pmk8550_die_temp             47.5=C2=B0C     47.3=C2=B0C     -0.3=C2=B0C
pmc8380_3_die_temp           48.4=C2=B0C     47.8=C2=B0C     -0.6=C2=B0C
pmc8380_4_die_temp           46.8=C2=B0C     46.4=C2=B0C     -0.4=C2=B0C
pmc8380_5_die_temp           48.6=C2=B0C     48.0=C2=B0C     -0.6=C2=B0C
pmc8380_6_die_temp           48.1=C2=B0C     47.3=C2=B0C     -0.7=C2=B0C
pm8550ve_8_die_temp          48.2=C2=B0C     47.3=C2=B0C     -0.9=C2=B0C
pm8550ve_9_die_temp          51.2=C2=B0C     50.6=C2=B0C     -0.7=C2=B0C

`usb_charger_right_therm` gained 2.3C in 10s, lost 1.4C 10s.
Clearly follows.

2. LHS charger getting plugged, 10s wait:
LABEL                         START        END       DIFF
pm8550_die_temp              47.6=C2=B0C     47.3=C2=B0C     -0.3=C2=B0C
vph_pwr_therm                51.6=C2=B0C     51.5=C2=B0C     -0.1=C2=B0C
usb_charger_right_therm      44.2=C2=B0C     43.6=C2=B0C     -0.5=C2=B0C
ssd_conn_therm               45.2=C2=B0C     45.0=C2=B0C     -0.2=C2=B0C
sys_therm5                   38.8=C2=B0C     38.6=C2=B0C     -0.2=C2=B0C
keyboard_therm               50.1=C2=B0C     49.9=C2=B0C     -0.2=C2=B0C
pm8550_gpio_01               50.0=C2=B0C     49.7=C2=B0C     -0.3=C2=B0C
pm8550_gpio_02               43.2=C2=B0C     43.3=C2=B0C     +0.2=C2=B0C
lpddr5_therm                130.0=C2=B0C    130.0=C2=B0C     +0.0=C2=B0C
usb_charger_left_therm       35.8=C2=B0C     35.8=C2=B0C     -0.0=C2=B0C
pm8550ve_2_die_temp          49.1=C2=B0C     48.8=C2=B0C     -0.2=C2=B0C
pmk8550_die_temp             46.6=C2=B0C     46.2=C2=B0C     -0.3=C2=B0C
pmc8380_3_die_temp           47.0=C2=B0C     46.8=C2=B0C     -0.2=C2=B0C
pmc8380_4_die_temp           45.6=C2=B0C     45.4=C2=B0C     -0.2=C2=B0C
pmc8380_5_die_temp           47.3=C2=B0C     46.8=C2=B0C     -0.5=C2=B0C
pmc8380_6_die_temp           46.7=C2=B0C     46.1=C2=B0C     -0.6=C2=B0C
pm8550ve_8_die_temp          46.2=C2=B0C     45.8=C2=B0C     -0.4=C2=B0C
pm8550ve_9_die_temp          49.8=C2=B0C     49.5=C2=B0C     -0.3=C2=B0C

Charger unplugged:
LABEL                         START        END       DIFF
pm8550_die_temp              47.3=C2=B0C     47.2=C2=B0C     -0.1=C2=B0C
vph_pwr_therm                51.4=C2=B0C     50.9=C2=B0C     -0.5=C2=B0C
usb_charger_right_therm      43.8=C2=B0C     43.4=C2=B0C     -0.4=C2=B0C
ssd_conn_therm               45.0=C2=B0C     44.8=C2=B0C     -0.1=C2=B0C
sys_therm5                   38.6=C2=B0C     38.4=C2=B0C     -0.2=C2=B0C
keyboard_therm               49.7=C2=B0C     49.3=C2=B0C     -0.4=C2=B0C
pm8550_gpio_01               49.6=C2=B0C     49.2=C2=B0C     -0.5=C2=B0C
pm8550_gpio_02               43.4=C2=B0C     43.3=C2=B0C     -0.1=C2=B0C
lpddr5_therm                130.0=C2=B0C    130.0=C2=B0C     +0.0=C2=B0C
usb_charger_left_therm       35.8=C2=B0C     35.8=C2=B0C     +0.0=C2=B0C
pm8550ve_2_die_temp          48.7=C2=B0C     48.4=C2=B0C     -0.3=C2=B0C
pmk8550_die_temp             46.1=C2=B0C     45.8=C2=B0C     -0.3=C2=B0C
pmc8380_3_die_temp           46.9=C2=B0C     46.5=C2=B0C     -0.4=C2=B0C
pmc8380_4_die_temp           45.4=C2=B0C     45.0=C2=B0C     -0.4=C2=B0C
pmc8380_5_die_temp           46.9=C2=B0C     46.5=C2=B0C     -0.4=C2=B0C
pmc8380_6_die_temp           46.3=C2=B0C     45.9=C2=B0C     -0.4=C2=B0C
pm8550ve_8_die_temp          45.8=C2=B0C     45.6=C2=B0C     -0.3=C2=B0C
pm8550ve_9_die_temp          49.5=C2=B0C     49.1=C2=B0C     -0.4=C2=B0C

pm8550_gpio_02 does NOT clearly follow. In your test you have
waited multiple minutes, which is enough to heat up a larger
area on the motherboard.

3. SSD stress test, 30s wait:
LABEL=09                      START=09   END=09     DIFF
pm8550_die_temp=09             45.7=C2=B0C=0951.6=C2=B0C=09   +5.9=C2=B0C
vph_pwr_therm=09             49.6=C2=B0C=0955.0=C2=B0C=09   +5.4=C2=B0C
usb_charger_right_therm=09     41.5=C2=B0C=0944.4=C2=B0C=09   +2.9=C2=B0C
ssd_conn_therm=09             42.9=C2=B0C=0947.9=C2=B0C=09   +5.0=C2=B0C
sys_therm5=09             36.7=C2=B0C=0936.9=C2=B0C=09   +0.2=C2=B0C
keyboard_therm=09             47.7=C2=B0C=0953.0=C2=B0C=09   +5.3=C2=B0C
pm8550_gpio_01=09             47.7=C2=B0C=0952.5=C2=B0C=09   +4.8=C2=B0C
pm8550_gpio_02=09             41.0=C2=B0C=0944.6=C2=B0C=09   +3.6=C2=B0C
lpddr5_therm=09            130.0=C2=B0C    130.0=C2=B0C=09   +0.0=C2=B0C
usb_charger_left_therm=09     35.7=C2=B0C=0935.9=C2=B0C=09   +0.2=C2=B0C
pm8550ve_2_die_temp=09     47.0=C2=B0C=0952.4=C2=B0C=09   +5.4=C2=B0C
pmk8550_die_temp=09     44.2=C2=B0C=0948.4=C2=B0C=09   +4.2=C2=B0C
pmc8380_3_die_temp=09     46.0=C2=B0C=0952.8=C2=B0C=09   +6.8=C2=B0C
pmc8380_4_die_temp=09     43.5=C2=B0C=0948.2=C2=B0C=09   +4.7=C2=B0C
pmc8380_5_die_temp=09     46.8=C2=B0C=0951.3=C2=B0C=09   +4.5=C2=B0C
pmc8380_6_die_temp=09     45.3=C2=B0C=0949.7=C2=B0C=09   +4.4=C2=B0C
pm8550ve_8_die_temp=09     44.2=C2=B0C=0947.4=C2=B0C=09   +3.2=C2=B0C
pm8550ve_9_die_temp=09     48.4=C2=B0C=0953.4=C2=B0C=09   +5.0=C2=B0C

Cooldown, 10s wait:
LABEL                         START        END       DIFF
pm8550_die_temp              50.9=C2=B0C     50.8=C2=B0C     -0.1=C2=B0C
vph_pwr_therm                54.0=C2=B0C     53.2=C2=B0C     -0.8=C2=B0C
usb_charger_right_therm      44.6=C2=B0C     44.5=C2=B0C     -0.0=C2=B0C
ssd_conn_therm               48.1=C2=B0C     47.9=C2=B0C     -0.2=C2=B0C
sys_therm5                   36.9=C2=B0C     37.0=C2=B0C     +0.0=C2=B0C
keyboard_therm               52.4=C2=B0C     51.7=C2=B0C     -0.7=C2=B0C
pm8550_gpio_01               52.1=C2=B0C     51.4=C2=B0C     -0.7=C2=B0C
pm8550_gpio_02               44.9=C2=B0C     44.8=C2=B0C     -0.0=C2=B0C
lpddr5_therm                130.0=C2=B0C    130.0=C2=B0C     +0.0=C2=B0C
usb_charger_left_therm       35.9=C2=B0C     35.9=C2=B0C     +0.0=C2=B0C
pm8550ve_2_die_temp          51.4=C2=B0C     50.6=C2=B0C     -0.8=C2=B0C
pmk8550_die_temp             48.2=C2=B0C     47.6=C2=B0C     -0.6=C2=B0C
pmc8380_3_die_temp           49.9=C2=B0C     49.1=C2=B0C     -0.7=C2=B0C
pmc8380_4_die_temp           47.4=C2=B0C     46.7=C2=B0C     -0.6=C2=B0C
pmc8380_5_die_temp           50.2=C2=B0C     49.2=C2=B0C     -1.0=C2=B0C
pmc8380_6_die_temp           48.9=C2=B0C     48.1=C2=B0C     -0.8=C2=B0C
pm8550ve_8_die_temp          47.2=C2=B0C     46.9=C2=B0C     -0.3=C2=B0C
pm8550ve_9_die_temp          52.4=C2=B0C     51.5=C2=B0C     -0.8=C2=B0C

This is a bit inconclusive. Both SSD, keyboard, and
pm8550_gpio_01 (LPDDR5, see below) heated up significantly.

4. Stress RAM, 10s wait:
LABEL                         START        END       DIFF
pm8550_die_temp              50.5=C2=B0C     51.0=C2=B0C     +0.5=C2=B0C
vph_pwr_therm                53.8=C2=B0C     55.9=C2=B0C     +2.1=C2=B0C
usb_charger_right_therm      45.8=C2=B0C     46.3=C2=B0C     +0.5=C2=B0C
ssd_conn_therm               47.8=C2=B0C     47.9=C2=B0C     +0.0=C2=B0C
sys_therm5                   39.9=C2=B0C     39.9=C2=B0C     -0.1=C2=B0C
keyboard_therm               52.0=C2=B0C     55.1=C2=B0C     +3.0=C2=B0C
pm8550_gpio_01               51.9=C2=B0C     54.7=C2=B0C     +2.8=C2=B0C
pm8550_gpio_02               45.6=C2=B0C     45.4=C2=B0C     -0.2=C2=B0C
lpddr5_therm                130.0=C2=B0C    130.0=C2=B0C     +0.0=C2=B0C
usb_charger_left_therm       35.9=C2=B0C     35.8=C2=B0C     -0.0=C2=B0C
pm8550ve_2_die_temp          51.0=C2=B0C     53.0=C2=B0C     +2.1=C2=B0C
pmk8550_die_temp             48.1=C2=B0C     49.3=C2=B0C     +1.1=C2=B0C
pmc8380_3_die_temp           50.8=C2=B0C     52.7=C2=B0C     +1.8=C2=B0C
pmc8380_4_die_temp           47.3=C2=B0C     49.7=C2=B0C     +2.4=C2=B0C
pmc8380_5_die_temp           50.0=C2=B0C     53.0=C2=B0C     +3.0=C2=B0C
pmc8380_6_die_temp           48.9=C2=B0C     52.9=C2=B0C     +4.0=C2=B0C
pm8550ve_8_die_temp          50.0=C2=B0C     51.4=C2=B0C     +1.4=C2=B0C
pm8550ve_9_die_temp          53.7=C2=B0C     55.7=C2=B0C     +2.0=C2=B0C

5. Cooldown, 10s wait:
LABEL                         START        END       DIFF
pm8550_die_temp              52.2=C2=B0C     51.3=C2=B0C     -0.8=C2=B0C
vph_pwr_therm                56.3=C2=B0C     55.2=C2=B0C     -1.1=C2=B0C
usb_charger_right_therm      47.2=C2=B0C     46.7=C2=B0C     -0.5=C2=B0C
ssd_conn_therm               49.0=C2=B0C     48.5=C2=B0C     -0.5=C2=B0C
sys_therm5                   39.4=C2=B0C     39.4=C2=B0C     -0.0=C2=B0C
keyboard_therm               54.7=C2=B0C     53.6=C2=B0C     -1.1=C2=B0C
pm8550_gpio_01               54.6=C2=B0C     53.4=C2=B0C     -1.1=C2=B0C
pm8550_gpio_02               45.8=C2=B0C     45.6=C2=B0C     -0.2=C2=B0C
lpddr5_therm                130.0=C2=B0C    130.0=C2=B0C     +0.0=C2=B0C
usb_charger_left_therm       35.9=C2=B0C     35.9=C2=B0C     +0.0=C2=B0C
pm8550ve_2_die_temp          53.5=C2=B0C     52.3=C2=B0C     -1.2=C2=B0C
pmk8550_die_temp             51.1=C2=B0C     50.0=C2=B0C     -1.1=C2=B0C
pmc8380_3_die_temp           51.5=C2=B0C     50.2=C2=B0C     -1.3=C2=B0C
pmc8380_4_die_temp           49.7=C2=B0C     48.7=C2=B0C     -0.9=C2=B0C
pmc8380_5_die_temp           51.4=C2=B0C     50.1=C2=B0C     -1.3=C2=B0C
pmc8380_6_die_temp           50.9=C2=B0C     49.8=C2=B0C     -1.1=C2=B0C
pm8550ve_8_die_temp          50.2=C2=B0C     49.3=C2=B0C     -0.9=C2=B0C
pm8550ve_9_die_temp          54.3=C2=B0C     53.3=C2=B0C     -1.0=C2=B0C

pm8550_gpio_01 and keyboard_therm clearly respond. This
would make sense, I am guessing two sensors are located
very close to each other on the motherboard, but on the
opposite sides of the PCBA.

6. Hairdryer on the keyboard, 10s wait:
LABEL                         START        END       DIFF
pm8550_die_temp              49.3=C2=B0C     49.1=C2=B0C     -0.2=C2=B0C
vph_pwr_therm                50.6=C2=B0C     50.4=C2=B0C     -0.2=C2=B0C
usb_charger_right_therm      43.7=C2=B0C     43.6=C2=B0C     -0.1=C2=B0C
ssd_conn_therm               46.4=C2=B0C     46.3=C2=B0C     -0.1=C2=B0C
sys_therm5                   36.8=C2=B0C     37.0=C2=B0C     +0.2=C2=B0C
keyboard_therm               49.6=C2=B0C     49.4=C2=B0C     -0.2=C2=B0C
pm8550_gpio_01               49.2=C2=B0C     48.9=C2=B0C     -0.2=C2=B0C
pm8550_gpio_02               44.1=C2=B0C     44.1=C2=B0C     +0.1=C2=B0C
lpddr5_therm                130.0=C2=B0C    130.0=C2=B0C     +0.0=C2=B0C
usb_charger_left_therm       35.9=C2=B0C     35.8=C2=B0C     -0.1=C2=B0C
pm8550ve_2_die_temp          48.1=C2=B0C     48.0=C2=B0C     -0.1=C2=B0C
pmk8550_die_temp             45.3=C2=B0C     45.1=C2=B0C     -0.2=C2=B0C
pmc8380_3_die_temp           46.0=C2=B0C     45.7=C2=B0C     -0.4=C2=B0C
pmc8380_4_die_temp           44.6=C2=B0C     44.3=C2=B0C     -0.3=C2=B0C
pmc8380_5_die_temp           46.3=C2=B0C     45.9=C2=B0C     -0.3=C2=B0C
pmc8380_6_die_temp           45.3=C2=B0C     45.0=C2=B0C     -0.3=C2=B0C
pm8550ve_8_die_temp          45.4=C2=B0C     45.1=C2=B0C     -0.3=C2=B0C
pm8550ve_9_die_temp          48.8=C2=B0C     48.6=C2=B0C     -0.2=C2=B0C

Another 10s wait:
LABEL                         START        END       DIFF
pm8550_die_temp              49.0=C2=B0C     49.6=C2=B0C     +0.6=C2=B0C
vph_pwr_therm                50.6=C2=B0C     51.0=C2=B0C     +0.5=C2=B0C
usb_charger_right_therm      43.7=C2=B0C     44.3=C2=B0C     +0.6=C2=B0C
ssd_conn_therm               46.5=C2=B0C     47.2=C2=B0C     +0.7=C2=B0C
sys_therm5                   37.5=C2=B0C     38.8=C2=B0C     +1.3=C2=B0C
keyboard_therm               49.6=C2=B0C     50.2=C2=B0C     +0.7=C2=B0C
pm8550_gpio_01               49.1=C2=B0C     49.7=C2=B0C     +0.6=C2=B0C
pm8550_gpio_02               44.6=C2=B0C     45.7=C2=B0C     +1.1=C2=B0C
lpddr5_therm                130.0=C2=B0C    130.0=C2=B0C     +0.0=C2=B0C
usb_charger_left_therm       35.8=C2=B0C     35.9=C2=B0C     +0.1=C2=B0C
pm8550ve_2_die_temp          48.2=C2=B0C     48.6=C2=B0C     +0.4=C2=B0C
pmk8550_die_temp             45.3=C2=B0C     46.1=C2=B0C     +0.8=C2=B0C
pmc8380_3_die_temp           46.0=C2=B0C     46.4=C2=B0C     +0.4=C2=B0C
pmc8380_4_die_temp           44.5=C2=B0C     45.2=C2=B0C     +0.6=C2=B0C
pmc8380_5_die_temp           46.3=C2=B0C     46.7=C2=B0C     +0.4=C2=B0C
pmc8380_6_die_temp           45.3=C2=B0C     46.0=C2=B0C     +0.7=C2=B0C
pm8550ve_8_die_temp          45.3=C2=B0C     46.1=C2=B0C     +0.8=C2=B0C
pm8550ve_9_die_temp          48.7=C2=B0C     49.6=C2=B0C     +0.9=C2=B0C

Cooldown, 10s wait:
LABEL                         START        END       DIFF
pm8550_die_temp              55.8=C2=B0C     55.3=C2=B0C     -0.5=C2=B0C
vph_pwr_therm                57.8=C2=B0C     57.3=C2=B0C     -0.5=C2=B0C
usb_charger_right_therm      51.0=C2=B0C     50.6=C2=B0C     -0.4=C2=B0C
ssd_conn_therm               54.0=C2=B0C     53.6=C2=B0C     -0.4=C2=B0C
sys_therm5                   45.8=C2=B0C     45.3=C2=B0C     -0.6=C2=B0C
keyboard_therm               56.3=C2=B0C     55.8=C2=B0C     -0.5=C2=B0C
pm8550_gpio_01               55.8=C2=B0C     55.4=C2=B0C     -0.4=C2=B0C
pm8550_gpio_02               52.5=C2=B0C     51.9=C2=B0C     -0.5=C2=B0C
lpddr5_therm                130.0=C2=B0C    130.0=C2=B0C     +0.0=C2=B0C
usb_charger_left_therm       36.0=C2=B0C     36.0=C2=B0C     +0.0=C2=B0C
pm8550ve_2_die_temp          54.7=C2=B0C     54.2=C2=B0C     -0.5=C2=B0C
pmk8550_die_temp             52.0=C2=B0C     51.6=C2=B0C     -0.4=C2=B0C
pmc8380_3_die_temp           51.5=C2=B0C     51.2=C2=B0C     -0.3=C2=B0C
pmc8380_4_die_temp           50.3=C2=B0C     49.9=C2=B0C     -0.4=C2=B0C
pmc8380_5_die_temp           51.9=C2=B0C     51.5=C2=B0C     -0.4=C2=B0C
pmc8380_6_die_temp           51.0=C2=B0C     50.8=C2=B0C     -0.2=C2=B0C
pm8550ve_8_die_temp          52.7=C2=B0C     52.4=C2=B0C     -0.3=C2=B0C
pm8550ve_9_die_temp          55.4=C2=B0C     55.1=C2=B0C     -0.3=C2=B0C

I would say it is also inconclusive; Looks more like
"sys_therm5" is the actual keyboard thermistor.

With this in mind:
ADC5_GEN3_AMUX1_GPIO_100K_PU - Likely "lpddr5_therm"
ADC5_GEN3_AMUX2_GPIO_100K_PU - Li
ADC5_GEN3_AMUX1_THM_100K_PU  -
ADC5_GEN3_AMUX2_THM_100K_PU  - RHS USB Charger
ADC5_GEN3_AMUX3_THM_100K_PU  -
ADC5_GEN3_AMUX4_THM_100K_PU  -
ADC5_GEN3_AMUX5_THM_100K_PU  -

Would like to hear how you arrived to the labels. I am
in parallel checking if tearing down the laptop would
help me identify which thermistor is which, but this
will take a while. Alternatively, I am leaning to drop
the labels for anything we are not sure about...

P.S. With most platforms starting sys_therm node count
from 1 and not 0, and schematics used to make this
mapping being wrong I would change this series to match
usual convention in the next series.

Regards,
Alex

>=20
> > +=09sys_therm0: channel@14a {
> > +=09=09reg =3D <ADC5_GEN3_AMUX1_GPIO_100K_PU(1)>;
>=20
> One note on the shape: hamoa-pmics.dtsi already defines
> channel@14a and channel@14b as pm8550_gpio_01 and pm8550_gpio_02,
> with gpio3 and gpio4 in high impedance for them. The EC's io-channels
> can reference those two directly; redefining the nodes in the board
> file only adds the labels, which the EC node does not need.
>=20
> Happy to test a v7 with the two channels moved.
>=20
> Liviu
> 
