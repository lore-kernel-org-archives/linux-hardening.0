Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697241;
	b=k1/p8HEc7rUrePze3ehdaK6fbHCYbkyu/SHTQOUE3G6/53KFqTFf9sbRIwfwPynLnsAG
	 pJJVf7qNRkJLi7+vM3OeUs94L91h0r+rAcaZGbJNzEPPO9CMaxV1nSV5Md1pIalZsiZiD
	 lZ2C6n9T7OMEfLh+m4zrgamJKuB6d+8kW63LgRRRYpDQz5EXXlpxTjgCnogwnYZJwcDNw
	 fzvEXRqvhZ5KtblQ5ILrIyfrMO+gZez60kw0vFPC35aDLnPSAsBnb0IRmghIAb7SvsNnz
	 B2dDWuMoT3yvr9WHkuoxAyAha/Uocb0ZNGTH432RdEruw4BCAEl2ML+rrlq0G7+N6Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UvQHobgH8Zb4rHJc4CXfEofhf12rBgJ9G+UkmAWeH18=;
	b=relCmYIsGp0EXEsCfF/URU/ovw6zJ02V/ezojzQnCYn1WXvQ061xON7nLGxkPPNaRwj1
	 NxEdQa4GVIRM5eFZqywbJI9lhRbPKZ03TZ7gNVk7KW+l/Ff2d2A6pKN5q2a1EAQA//oVS
	 JXEEfXjXwWUicAJ8LgI8D1N7cEatK2oFVWHtUGsqEh2AXHmUzCZW88KIdlXs5tO7Je8oj
	 OoZ+unkLXACLaGjkIXRJa08g1SvMPFcrV82btAxw0VqOYqn0AH+Vtd4nqfTSEQpa2y6Bb
	 jyl0bNOXUnhsHW0f8FU3XLPx5OuRs34MKUfbXCJoWCGT8yyuhZNmImjjUKBv3E9kAZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=thinkoid.org;
	spf=none smtp.mailfrom=thinkoid.org;
	dkim=pass header.d=thinkoid-org.20251104.gappssmtp.com header.i=@thinkoid-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=zhfZQOTK;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54859606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 19:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54859606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thinkoid.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=thinkoid.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=thinkoid-org.20251104.gappssmtp.com header.i=@thinkoid-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=zhfZQOTK
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f1e5d7450so10821985a.2
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thinkoid-org.20251104.gappssmtp.com; s=20251104; t=1792697239; x=1793302039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UvQHobgH8Zb4rHJc4CXfEofhf12rBgJ9G+UkmAWeH18=;
        b=zhfZQOTKLhfJXm5LG7URakF+NxBk8bk9htV9atsIWMIUWrU23y7Sfypddxdak+rC3i
         PMYT/8uaey1X82aqk34aRLpVr2lJfr0AV634/gAmPx50zofgvvaTW+QNmNoCja4ZjVaL
         02Nx8Bpbt+v1DsTKhFrexDMQGgpCYQjPIHqvvbCxam1OokDmFvqL2Zf8/2AY3S3aLOUW
         jTRqtHAprU7w3Ia1FulRoOXZLlwn71GzVkf+/kB8LtXmBY1Y6fhfUSWgxlpTFRVIU4xE
         s2NVxm4x4w5wU+lSdKeE4oHSfpC5VkQdC1Lh7ikpJgQbh1u39glIH6sgf/+glyqalNrw
         6qNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697239; x=1793302039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UvQHobgH8Zb4rHJc4CXfEofhf12rBgJ9G+UkmAWeH18=;
        b=ZdYWraavIuQlbCGov8nab5VPH4Pjb0Jte3e7tCofRzlZUkObyrgemiyK1YbYnVjMoi
         krvMEIdjv+2hB0GKofmryAZAwJws7bbyPnRjn950YN+8/7gDKWkTJ1wnvnZm74lSfC3v
         jZGpTJniw8KfNahjPGkIcfPrXF3wVC2gHDKOJm6MxIFsWe62ONyzny1XTI89Rt25ewl0
         t8wAPhafkCaowPAqKnXF3o70aVmxG0rWktcDcd4nOwe8hOc4+WWy3T/mcBidlg3Ii/Zt
         urGmcF7D5XrvILykSmSwe+5VHdv9h1mK9zuV/spzPys8LMmokX1Wkm+U21T5bjcIVRx6
         F6MA==
X-Forwarded-Encrypted: i=1; AKwUvBxvM+tNSLJhsoiBT2htymYHG95J0yhjLuFVB4PLihBmQnTx/syy5j9E5f3fcc9iAxTxyyxLUNZLbEHxUtUAujQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJl6xDjegN1E6yuCRfiewGb6XIUZM+QPzt+uOIPkn95nOmKQJQo
	vMXNe2MmHsqT0uQCDmBQ/ngQ8pA/N4Mniq/YUOVLtowVd7FybovBSnkUM4x2QLGssnc=
X-Gm-Gg: AYBFou0VWhGfV0tuB4iIZ/O6ii8FVNmTHuFtpg0K9HpcgfNGxZImbKua4thX7JrVZ93
	aOycUO64OiTy4HJ84y8xMWduVn+Iw6R5GDNT43aWt6hYSj9d43ZN7zWGnkbqI5BzDrrZVmpzHG+
	bQFh3SIVFCwTo5kQBa5YoMo6cbsP+o6BDH/vvdTRWZeOBepOPlGLslJm4ud1KOugTsOayrsc3fh
	cYijiukpRYnF+SAfpLsAAO/0k/Qp96CI7MhSttdA/VOfrjapfCZH7+tGiG63pfChck/ZMFByEHO
	5Ev16TE5oAs0p/IUvRvB0uti7YPa9dO0nzGBG4eAAC5x94iPBoPokkPRZAgx3xe1N1VAFcISLx0
	ICCbHolLm1y6uNS0hPSFoe8LpfiEQtscW12muM0K/hWQ28/6aOF1/gGLD10sF/lNfNEC3Z1mVp0
	xBCDd/HIHGUMehFuiMuwOchv1BctAbNj03BHpxgmWdWW/IfShqUmHmrRdBDaT7VkdEUE2TNmXM7
	9rXc4dPfj9HymkteR24IQH0W0Mp/eumh+7n
X-Received: by 2002:a05:620a:44d3:b0:93e:fa30:f1dc with SMTP id af79cd13be357-93f6f8c01cemr79549185a.72.1792697238908;
        Thu, 22 Oct 2026 12:27:18 -0700 (PDT)
Received: from behemoth ([2605:a601:9b7d:cc00::c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f6fb82b87sm30290185a.13.2026.10.22.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:27:18 -0700 (PDT)
From: Liviu Nicoara <lnicoara@thinkoid.org>
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Michael Burch <me@michaelburch.net>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Tobias Heider <tobias.heider@canonical.com>,
	Val Packett <val@packett.cool>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345: introduce EC
Date: Thu, 22 Oct 2026 15:27:09 -0400
Message-ID: <20261022192709.12149-1-lnicoara@thinkoid.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <NCQ5O8k2_GpmJZBjDzgZL67uwdiYmmuSudO9VmdRaFTDq0u7aec6at00VYbzdwwSVvgJnLnGxewwp_TVO9oTjM2pAjP_LoiURf9JCIKXB-w=@vinarskis.com>
References: <NCQ5O8k2_GpmJZBjDzgZL67uwdiYmmuSudO9VmdRaFTDq0u7aec6at00VYbzdwwSVvgJnLnGxewwp_TVO9oTjM2pAjP_LoiURf9JCIKXB-w=@vinarskis.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 22 Oct 2026 17:07:25 +0000, Aleksandrs Vinarskis wrote:
> I do not think the left charger you identified is correct - how did
> you arrive to that conclusion? Curious to compare to my method.

I am afraid my method was simpler and coarser than yours: one run per
port, nineteen samples ten seconds apart, the charger feeding the
system only (battery at 96 % and not charging), on a 7.2.6 kernel
with all four GPIO channels in one DTB. The deltas over three minutes:

Channel                Left charger   Right charger
0x14b  AMUX2_GPIO          +1.6           -0.9
0x145  AMUX2_THM           +0.1           +3.4
0x146  AMUX3_THM           +0.8           -0.1
0x14a  AMUX1_GPIO          -0.2           +1.3
0x144  AMUX1_THM           -0.1           +0.2
0x148  AMUX5_THM           -0.2           +1.2
0x147  AMUX4_THM           +0.1           +1.8
0x14d  AMUX4_GPIO          +0.0           -0.0

The other channels fell or held while 0x14b rose, so it was not the
board warming as a whole. But 1.6 C in three minutes, against your
2.3 C in ten seconds on the right, might mean that 0x14b is a sensor
somewhere on the left side of the board, not necessarily on the left
port's power path. Under SSD load it moved with 0x146 and fell with
it in cool-down, which puts it close to the SSD. "Left charger" was
my reading of the sign pattern. Your ten-second test is probably the
better discriminator for a sensor on a power path. If nothing answers
the left charger in ten seconds, the simpler reading is that the left
port has no thermistor of its own among these seven.

> pm8550_gpio_02 does NOT clearly follow. In your test you have
> waited multiple minutes, which is enough to heat up a larger
> area on the motherboard.

Agreed. In your left run it was the only channel with a positive
delta while the board drifted down, which is the same weak signal I
had, and no more than that.

On the two AMUX3/AMUX4 GPIO channels: neither carries a thermistor
on this unit, and your tables say the same for yours. 0x14c reads
130.048 C on every sample, the last row of the conversion table,
where the driver clamps a voltage at or below the lowest it knows.
Its input sits near 0 V. Windows' ADC configuration sets up only
PM8550 GPIO3 and GPIO4 as analog inputs, for AMUX1 and AMUX2, so the
pin behind AMUX3 is in its digital default, and PM8550's low GPIOs
read back here as inputs with a 10 uA pull-down. 0x14d held 34.7 C
within 0.1 C through both chargers and two load runs on this unit,
and 35.8 to 36.0 C through every one of your tests, the hairdryer
included. That is a biased pin, not a sensor. Both nodes can go.

> ADC5_GEN3_AMUX1_GPIO_100K_PU - Likely "lpddr5_therm"

I cannot separate 0x14a from 0x144 and 0x148 by heating. Under a
one-core load reading a file from /dev/shm they rose 14.0, 14.4 and
14.2 C in lockstep, while the SoC's mem TSENS zone rose 20 C. Your
RAM stress warmed every PMIC die by 1 to 4 C as well, so it does not
single out 0x14a either. The three sit with the SoC; which one is the
memory I cannot tell.

> Looks more like "sys_therm5" is the actual keyboard thermistor.

Consistent with what I see. 0x147 is the coolest of the seven, 29 C
at idle, and nearly indifferent to board loads: it gained 2.0 C where
0x144 gained 9.2 under SSD I/O, and 2.5 C where 0x144 gained 14.4
under the CPU load. A sensor away from the board, on the skin side,
fits.

On 0x146: under four minutes of direct-I/O reads it rose 8.2 C
against 10.0 C on the NVMe's own sensor, the largest share of any
channel, and it fell at once when the load stopped while the
SoC-side channels kept rising. Under the CPU-only control its share
halved. I would keep "ssd_conn_therm" on it with partial confidence,
but I will not argue if it goes with the others.

> Alternatively, I am leaning to drop the labels for anything we are
> not sure about...

Or just give them pirate names. Jk.

Agreed. 0x145 as the right charger is what both of us measured.
Everything else is a guess until the teardown. Numbering sys_therm
from 1 matches Windows' SYS_THERM1 to 7, so that helps too.

One consequence on my side: the 9345 thermal-zones patch
(20261006185557.23016-1-lnicoara@thinkoid.org) names its zones
chg-left on 0x14b and ssd on 0x146. I will respin it with neutral
names for the zones that are not settled, so the two patches agree.

Happy to test a v7, including a lid close on the EC interrupt line,
which my v6 run did not cover.

I love this laptop, but I will not open it up just to pinpoint the
right thermistors' locations.

Liviu
