Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319B72853EE
	for <linux-hardening@vger.kernel.org>; Wed,  7 Jan 2026 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787955; cv=none; b=HP5ePO5sUHfz+vQSUQFlMYDnIEfcP0/B0gEeOMR7H2OMzmhM1NFy6oCJ0WoL84u2Hn5kcr7b4GMrD418I/zsVxa3jVbSuXxh+iiWoiFiUcHUDekm+SrfBu004pijOMXQp06IG0K3nJPmZROgYzN3m4X1GApQpZCMvF7cZC3yyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787955; c=relaxed/simple;
	bh=pTQnoqmGL8NufSqpGKZACn3N8NzVAcqejg06RNbRnHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snir4+3FXhqLkcjgIJpYWHdelLT9ftI7VAlaFk6AEwPE+dArr3w7tUIqlsNpOK2lDMZDnP3SJFMGl5Mc8LAPZ7mpqw7UWFBvxQYKMefvDH1jVicGXG9D4YdC1RbCXPo1E2kDyqydhoDO2gZOUENdbovLC6StjiqPQTVuA+NrHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fo6e4NzI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fn2VK+zU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fo6e4NzI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fn2VK+zU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079COET2454339
	for <linux-hardening@vger.kernel.org>; Wed, 7 Jan 2026 12:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CglZm0Bx0vloewTjIpSITntSyRCFjdmTE/x+ud8hzXQ=; b=Fo6e4NzIcMR0k+UP
	dYRj0xCalJw56YEttQyeT5CbSBcrRLDNRycqgwnXrn3jhnbY3rhYD1UCuPEp6ocQ
	BDqTV1s4bUal2pnvyfn3irAj711AqpP4AUM8qcSu3ir+S924HtHGI/FsQ5sCMBZO
	VZ8fzBpiFuP8M1ynUu+Ih7uaVlw57QLQR2wFzJDrnWce+j18Exh4M/6oCfCSOHX8
	Wo3RvRYB+itS/9vfGnrpcUlByOkV66+K5EFGIbhd2MoWe4tYbPQeOMef1WjHJQVK
	1wNxhg+hlYL5nXZJ9QkucueGiLzmiQmMnV2iDN1QwNGCe52uLXKMcgOkYNm05UEE
	O7qZuQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhmnbggx7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 07 Jan 2026 12:12:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1d26abbd8so63612091cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 07 Jan 2026 04:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767787952; x=1768392752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CglZm0Bx0vloewTjIpSITntSyRCFjdmTE/x+ud8hzXQ=;
        b=Fn2VK+zUlOTVSMxF3Py/B0Th/6MRbw0MZ8bPQ6ps/uYRXrCTyhkJyUDv0KUhcs/h1W
         YP7Ky7LcK3p02dfoa+HfWD4CCBX5353C5bj3JZv5cuL8Bz5WUkRVZB1t0dgsJZ11uLxv
         ojVB/aDYaWZ96Hai2AXUwUxbxnevDUiTKy6fngZGag0Iy0HE2wk7FGwK9ahnqxYUbU5E
         N7G3C2XBjJY/EYHFyzp20E3dEt2bn6Od+3McMDB2WeM5qkzuuCtaWswkQOD34bfXjTU2
         TYwduJcq8KxWPaOGvQazJ5ieSo/cWWFMgo7PLeJUP006U4B/Rdqw2GDOZc6jbRWJnos1
         FJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767787952; x=1768392752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CglZm0Bx0vloewTjIpSITntSyRCFjdmTE/x+ud8hzXQ=;
        b=MBjS8gT/SVUtX3NVXRdoWYO4S7z3+cENlkduAvmSLLVLb6UHB8GDs3a+DDgST3w79f
         CrbYhYt6aLwLyUvQS3POTPwKrFaFaHxKBLxCICDWbDvS0Xt2PenwMrN+Yw+eDDIRaksY
         Tscpx5Wsv9BuxhNTpY2X6TTDX7Ea8GiZzO2T2ZrWoThX8Ge7ICZJikYbU4B3omEfgzu3
         JjftSc48ofLqLtKW/umlyL8oVcuG36X5hAkEsspIVj3PwaBAZjutz7aMYS0GL0L6IAdg
         Nlddw5b5h8r0U4O/6E1AkS1yQz2uOftWPUFiGjqMQAWidlz2g2MbxDB89PUWC+XpdoQ2
         b7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCW/48g0anJd6CFt2xte74LQcCAbMJAqYhc0r9DKsTU9S9nMATcDL9Z/y078+8tUoqnnhSbRqO1eEPb2kxGHlO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQwNvyeuVO3XzN0vjKVRKPOvi4bjcE+ZZ57LsWkElvNBN5oBct
	yQ7ftNiUc2gt093j5BpStFnrmQrnhrpoMOr9iWrfjhjPoaxvmWz11TEGaHYwl62RX9Q/EU68GLN
	v26y3Z49EX+ljJ5anph5O2Z10jDlgvTeSbUg8cLurg5n0Yk8flyEU+3j64P2QPDwo2SIw9RM=
X-Gm-Gg: AY/fxX4d6FfnriRwvUXoudNuBeezGS/hQJyCeA3jPjSzgc5DOnkwsEOKLf9mm15PIfr
	urbj70JDTw8xBmU9tBJVwcArxb7giGufx+LUD4MMVv7cSLMKugrO/ZvCLkWFe083p88sc+4fmaG
	vEx1eOXNxCgY+/yXQnC8bi7/y6rEiQswP+09ssh9nJukJMw8gMq/sCAkUY3fqHik6slktQ/OexA
	W2LUJXNCmjDWbOWO5nlSvrIdzHy8D6KvOxb1gN0YKDOka3WAsPtelinfo84hU3H+ULVvm/xxLDD
	Ufq/0DpAyVimyzuSFmXadiOM4PxC+RvhILanW2paJoE5hFantCtWzEGG+rQ11ZxhyX15Yh3Dj7N
	A7Ib46AhYaWnFVGMten5GFOUoKvmxIGmMtHOY1paKx8ntjtzXjSsEZ1jufp+nDfrBVy4MDJlJnV
	loSzJGXzbrKezhAmw2csjkoMk=
X-Received: by 2002:a05:622a:5916:b0:4f3:59a7:67b3 with SMTP id d75a77b69052e-4ffb48c4709mr28503181cf.20.1767787952363;
        Wed, 07 Jan 2026 04:12:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2A3iR7hDKHrT8sGDdbHZBXbjLAGksj23v1DrOVBJA4EhIdUY291ne567GafOnCt1i9gA9ow==
X-Received: by 2002:a05:622a:5916:b0:4f3:59a7:67b3 with SMTP id d75a77b69052e-4ffb48c4709mr28502701cf.20.1767787951887;
        Wed, 07 Jan 2026 04:12:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea814sm1289794e87.12.2026.01.07.04.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:12:31 -0800 (PST)
Date: Wed, 7 Jan 2026 14:12:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>,
        Mika Westerberg <westeri@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 00/10] gpio: improve support for shared GPIOs
Message-ID: <p4fwvwbhwbdpiqvspjq4stjyuxy5pqvdei3wfianw4aeujmgbx@utumnrffangf>
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
 <fimuvblfy2cmn7o4wzcxjzrux5mwhvlvyxfsgeqs6ore2xg75i@ax46d3sfmdux>
 <uc7utm7tbtmkk6osaoydibd5evtpm246sjrpkx3lpclpk4srea@a4g65oduswau>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uc7utm7tbtmkk6osaoydibd5evtpm246sjrpkx3lpclpk4srea@a4g65oduswau>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA5NCBTYWx0ZWRfX+4D27ze8tfxN
 QQUnbeGlNVlY/VzngM+E8kePOxtsqLshsxE8O4aA08Hfx1HkEDbVJI3NcJ57a4fXu+7T+x9IM3K
 6nHdqW3qy0aHP+AaAdqqh+D7XBBjgFNWSb8RrxcTdBWqwPxjh24nxXFOiybOonwyzmY2B1phqLO
 l3J2GxyrMd2xkkM+rEWXI+h4monNsZac0zJL1R7t7mGaTfT5aqgrrVfsYcn101ACb+ZHRFqY5KJ
 s+PMGyd2d4z3n50NajuEoAh8bZz31iEZ9j407tihAR6qb8sTPgkpaPDbjImcPBO9O2kICR6OV2U
 /Fs6Zey0oInWc3h+GHImyDUFYNl0AL+4yd6rmdQ93snuIP2RSrMH8E7DYI5nOEVIFsW32vDKGk+
 TxrAa8dwKMidMOxgwd27mmWJEI0c4BPNKIruFc4NJ9t5cLeuM1hpyPKfXezLaWrvgNK/chYliaI
 QSPUvHFx6XxMr7fhx9w==
X-Proofpoint-GUID: P7666mzNXclvhyMWWuvk4d0i3bzm75CA
X-Authority-Analysis: v=2.4 cv=eIkeTXp1 c=1 sm=1 tr=0 ts=695e4db1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sWqkpiAQKYQcFBEJubgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: P7666mzNXclvhyMWWuvk4d0i3bzm75CA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070094

On Wed, Jan 07, 2026 at 05:17:09PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Nov 26, 2025 at 06:27:13PM +0200, Dmitry Baryshkov wrote:
> > On Wed, Nov 12, 2025 at 02:55:29PM +0100, Bartosz Golaszewski wrote:
> > > Bjorn, Konrad: I should have Cc'ed you on v1 but I just went with what
> > > came out of b4 --auto-to-cc. It only gave me arm-msm. :( Patch 7 from
> > > this series however impacts Qualcomm platforms. It's a runtime dependency
> > > of patches 8 and 9. Would you mind Acking it so that I can take it into
> > > an immutable branch that I'll make available to Mark Brown for him to
> > > take patches 8-10 through the ASoC and regulator trees for v6.19?
> > > 
> > > Problem statement: GPIOs are implemented as a strictly exclusive
> > > resource in the kernel but there are lots of platforms on which single
> > > pin is shared by multiple devices which don't communicate so need some
> > > way of properly sharing access to a GPIO. What we have now is the
> > > GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which was introduced as a hack and
> > > doesn't do any locking or arbitration of access - it literally just hand
> > > the same GPIO descriptor to all interested users.
> > > 
> > > The proposed solution is composed of three major parts: the high-level,
> > > shared GPIO proxy driver that arbitrates access to the shared pin and
> > > exposes a regular GPIO chip interface to consumers, a low-level shared
> > > GPIOLIB module that scans firmware nodes and creates auxiliary devices
> > > that attach to the proxy driver and finally a set of core GPIOLIB
> > > changes that plug the former into the GPIO lookup path.
> > > 
> > > The changes are implemented in a way that allows to seamlessly compile
> > > out any code related to sharing GPIOs for systems that don't need it.
> > > 
> > > The practical use-case for this are the powerdown GPIOs shared by
> > > speakers on Qualcomm db845c platform, however I have also extensively
> > > tested it using gpio-virtuser on arm64 qemu with various DT
> > > configurations.
> > > 
> > > I'm Cc'ing some people that may help with reviewing/be interested in
> > > this: OF maintainers (because the main target are OF systems initially),
> > > Mark Brown because most users of GPIOD_FLAGS_BIT_NONEXCLUSIVE live
> > > in audio or regulator drivers and one of the goals of this series is
> > > dropping the hand-crafted GPIO enable counting via struct
> > > regulator_enable_gpio in regulator core), Andy and Mika because I'd like
> > > to also cover ACPI (even though I don't know about any ACPI platform that
> > > would need this at the moment, I think it makes sense to make the
> > > solution complete), Dmitry (same thing but for software nodes), Mani
> > > (because you have a somewhat related use-case for the PERST# signal and
> > > I'd like to hear your input on whether this is something you can use or
> > > maybe it needs a separate, implicit gpio-perst driver similar to what
> > > Krzysztof did for reset-gpios) and Greg (because I mentioned this to you
> > > last week in person and I also use the auxiliary bus for the proxy
> > > devices).
> > 
> > Hi,
> > 
> > I'm sorry if this was already reported and fixed. On Qualcomm RB5
> > platform with this patchset in place I'm getting the following backtrace
> > (and then a lockup):
> > 
> 
> On Rb3Gen2 this breaks UFS:
> 
> 	ufshcd-qcom 1d84000.ufshc: cannot find GPIO chip gpiolib_shared.proxy.4, deferring

CONFIG_GPIO_SHARED_PROXY=y ?

> 
> But MMC acquired the GPIO successfully,
> 
> 	sdhci_msm 8804000.mmc: Got CD GPIO
> 
> But I can see gpiochips registered as well:
> 
> (initramfs) ls /dev/gpio*
> crw------- 1 0 0 254,0 /dev/gpiochip0
> crw------- 1 0 0 254,1 /dev/gpiochip1
> crw------- 1 0 0 254,2 /dev/gpiochip2
> crw------- 1 0 0 254,3 /dev/gpiochip3
> crw------- 1 0 0 254,4 /dev/gpiochip4
> 
> Let me know if you need more info.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
With best wishes
Dmitry
