Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966577;
	b=2emAVXoew76Y1XLRRPFismURSGtn73L36kpWXLLGynPSW9536jKB3KjU4ZJfY4Zj1AmY
	 vzKbt4NmvdTv5JIbcHCrxV7cYuAm93yUFvp5+FQAMiZsERCmb6yRpLLHW4HAN2UBQV7oY
	 7ZoPXaAX6BUrFWvhN48Eeiux2orit7nRssv2FyuErx+ie4XiATNEIOeWq+lpPLFLjCeAH
	 ONgWh+ZlzWGoEdq0Suxn+SaFYP01pQwL/4yQ17gZVjjLTcybPZnufvd1MtQTqej8n1GIv
	 VdqrP8mM569709ihsrWYuYSIZ1u7r51G6Y0Ki64ytZySQ4cOOYmM502msnW5qu7NaDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966577;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=DMnV/6aSn1ZXSp1qQ4XFqAj3ot4W3oi4+OfSLRlndkc=;
	b=Gzm1HrE/GhBH+w19VHeMh+/9t8ItoifKX2sXSLQtUUJSZBskfwh0rBWCvQhIYpMhsFoB
	 iGEcE30WoSiQ4cJZYSzFbqPYbUqolDYIaGRjgAds+yUitGkvCPdfxvYSrZzkeNFwbm4Qr
	 q6WA8IPn3JSvQT6ohVomXHlr/Z6+mMBT2B0g5DCBdKFX93mIVeFPMGW6VjyBy7JCdkJKp
	 FfqpWJrTux/hrrodJwTzyHstGXYqLohaL4VwTPCkKUZ/jv2QKuYw2IE3CXkDn0hFkBXlu
	 uOzkduozFgTIXc6NZUOkrECab/DWfiBxsHiVXMym6FlYCdC5UXZv6GPb+pIpk6EilwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vinarskis.com;
	spf=pass smtp.mailfrom=vinarskis.com;
	dkim=pass header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=FzFEwH16;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8034606A31D
	for <linux-hardening@vger.kernel.org>; Sun, 25 Oct 2026 22:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8034606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinarskis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vinarskis.com header.i=@vinarskis.com header.a=rsa-sha256 header.s=protonmail3 header.b=FzFEwH16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vinarskis.com;
	s=protonmail3; t=1792966573; x=1793225773;
	bh=DMnV/6aSn1ZXSp1qQ4XFqAj3ot4W3oi4+OfSLRlndkc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FzFEwH163Kethc0JpXcJAw5b98NkdekC+gczB91jtDHhg4YCXncWSKMzoePU73eyk
	 7xecNkYt7sny7Wex8uMGZbMIEREPOWh4XB/51TSqoWYyoNW91N1mjTKv3eXaASVoPN
	 btMettP4GvM5nzts47lCEf28kyOCHfNWpkBTsObcGDbailPlkZ6Bod1Bwiabi4ZCkb
	 lQz7LmGq9e42ZEMKa5IAwGvwuQTkuOVEQ11UW538sn6z5e3y2QSt1v7Q7q0h9rFKyf
	 W0qbuB1uYzSZ2OCCXNy47a+YmNZcOI5n2s8YdxVVKPfIihltjF4QGTO4CLisPeWHij
	 V+1N3Z+XvM3rA==
Date: Sun, 25 Oct 2026 22:16:07 +0000
To: Liviu Nicoara <lnicoara@thinkoid.org>
From: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Michael Burch <me@michaelburch.net>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>, Tobias Heider <tobias.heider@canonical.com>, Val Packett <val@packett.cool>, Neil Armstrong <neil.armstrong@linaro.org>, Stephan Gerhold <stephan.gerhold@linaro.org>, linux-hardening@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345: introduce EC
Message-ID: <tgnlBNUOnW42EiLCz_akAzeeWkNknNtC0L6XgPu22x5snLwk-jvS8K8byxz0LVhf-i0Zi5deKpU5UuE0QqzqMOZHx6OqLcpSllgj6JyZAAM=@vinarskis.com>
In-Reply-To: <20261022192709.12149-1-lnicoara@thinkoid.org>
References: <NCQ5O8k2_GpmJZBjDzgZL67uwdiYmmuSudO9VmdRaFTDq0u7aec6at00VYbzdwwSVvgJnLnGxewwp_TVO9oTjM2pAjP_LoiURf9JCIKXB-w=@vinarskis.com> <20261022192709.12149-1-lnicoara@thinkoid.org>
Feedback-ID: 158356072:user:proton
X-Pm-Message-ID: 18a3e30b6d997ba5a1b9c6346f460aaab43f928c
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





On Thursday, October 22nd, 2026 at 21:27, Liviu Nicoara <lnicoara@thinkoid.=
org> wrote:

> On Thu, 22 Oct 2026 17:07:25 +0000, Aleksandrs Vinarskis wrote:
> > I do not think the left charger you identified is correct - how did
> > you arrive to that conclusion? Curious to compare to my method.
>=20
> I am afraid my method was simpler and coarser than yours: one run per
> port, nineteen samples ten seconds apart, the charger feeding the
> system only (battery at 96 % and not charging), on a 7.2.6 kernel
> with all four GPIO channels in one DTB. The deltas over three minutes:
>=20
> Channel                Left charger   Right charger
> 0x14b  AMUX2_GPIO          +1.6           -0.9
> 0x145  AMUX2_THM           +0.1           +3.4
> 0x146  AMUX3_THM           +0.8           -0.1
> 0x14a  AMUX1_GPIO          -0.2           +1.3
> 0x144  AMUX1_THM           -0.1           +0.2
> 0x148  AMUX5_THM           -0.2           +1.2
> 0x147  AMUX4_THM           +0.1           +1.8
> 0x14d  AMUX4_GPIO          +0.0           -0.0
>=20
> The other channels fell or held while 0x14b rose, so it was not the
> board warming as a whole. But 1.6 C in three minutes, against your
> 2.3 C in ten seconds on the right, might mean that 0x14b is a sensor
> somewhere on the left side of the board, not necessarily on the left
> port's power path. Under SSD load it moved with 0x146 and fell with
> it in cool-down, which puts it close to the SSD. "Left charger" was
> my reading of the sign pattern. Your ten-second test is probably the
> better discriminator for a sensor on a power path. If nothing answers
> the left charger in ten seconds, the simpler reading is that the left
> port has no thermistor of its own among these seven.
>=20
> > pm8550_gpio_02 does NOT clearly follow. In your test you have
> > waited multiple minutes, which is enough to heat up a larger
> > area on the motherboard.
>=20
> Agreed. In your left run it was the only channel with a positive
> delta while the board drifted down, which is the same weak signal I
> had, and no more than that.
>=20
> On the two AMUX3/AMUX4 GPIO channels: neither carries a thermistor
> on this unit, and your tables say the same for yours. 0x14c reads
> 130.048 C on every sample, the last row of the conversion table,
> where the driver clamps a voltage at or below the lowest it knows.
> Its input sits near 0 V. Windows' ADC configuration sets up only
> PM8550 GPIO3 and GPIO4 as analog inputs, for AMUX1 and AMUX2, so the
> pin behind AMUX3 is in its digital default, and PM8550's low GPIOs
> read back here as inputs with a 10 uA pull-down. 0x14d held 34.7 C
> within 0.1 C through both chargers and two load runs on this unit,
> and 35.8 to 36.0 C through every one of your tests, the hairdryer
> included. That is a biased pin, not a sensor. Both nodes can go.
>=20
> > ADC5_GEN3_AMUX1_GPIO_100K_PU - Likely "lpddr5_therm"
>=20
> I cannot separate 0x14a from 0x144 and 0x148 by heating. Under a
> one-core load reading a file from /dev/shm they rose 14.0, 14.4 and
> 14.2 C in lockstep, while the SoC's mem TSENS zone rose 20 C. Your
> RAM stress warmed every PMIC die by 1 to 4 C as well, so it does not
> single out 0x14a either. The three sit with the SoC; which one is the
> memory I cannot tell.
>=20
> > Looks more like "sys_therm5" is the actual keyboard thermistor.
>=20
> Consistent with what I see. 0x147 is the coolest of the seven, 29 C
> at idle, and nearly indifferent to board loads: it gained 2.0 C where
> 0x144 gained 9.2 under SSD I/O, and 2.5 C where 0x144 gained 14.4
> under the CPU load. A sensor away from the board, on the skin side,
> fits.
>=20
> On 0x146: under four minutes of direct-I/O reads it rose 8.2 C
> against 10.0 C on the NVMe's own sensor, the largest share of any
> channel, and it fell at once when the load stopped while the
> SoC-side channels kept rising. Under the CPU-only control its share
> halved. I would keep "ssd_conn_therm" on it with partial confidence,
> but I will not argue if it goes with the others.
>=20
> > Alternatively, I am leaning to drop the labels for anything we are
> > not sure about...
>=20
> Or just give them pirate names. Jk.
>=20
> Agreed. 0x145 as the right charger is what both of us measured.
> Everything else is a guess until the teardown. Numbering sys_therm
> from 1 matches Windows' SYS_THERM1 to 7, so that helps too.
>=20
> One consequence on my side: the 9345 thermal-zones patch
> (20261006185557.23016-1-lnicoara@thinkoid.org) names its zones
> chg-left on 0x14b and ssd on 0x146. I will respin it with neutral
> names for the zones that are not settled, so the two patches agree.
>=20
> Happy to test a v7, including a lid close on the EC interrupt line,
> which my v6 run did not cover.
>=20
> I love this laptop, but I will not open it up just to pinpoint the
> right thermistors' locations.

I went ahead and tested thermistors against their potential names.
Finding are available here:
https://github.com/alexVinarskis/linux-x1e80100-dell-tributo/blob/master/de=
ll-xps13-9345-ec.pdf

TL;DR: with your correction of AMUX GPIOs to 1, 2 instead of 3, 4 most=20
of the proposed labels are correct, except for left charging controller.
This thermistor is quite far away such that IMO it cannot be associated
with the charger. This perfectly explains the difference in heating up
rate we both observed.

I will adjust labels, address rest of the comments and respin series
shortly.

Regards,
Alex

>=20
> Liviu
> 
