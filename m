Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25727421253
	for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531805; cv=none; b=qtZNKIo7JBvP87ZMKz3Zz4fJC5SaTlQ9bjR988pkVKWE6fdqwN8qgiUX7DUMv2cyBTxKCE4gTrNTUTyUu2/cHj5qhz8iCugG/Smprbc2AwCJG2jvUXehOVEYaJL4NHeWGzWOJUsf72INhaUxrNuTHIRRjEhlSgNVYLfyNX7Unek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531805; c=relaxed/simple;
	bh=29uv9rNNOe8cJpC4RVfKo9oF63UjVRrTJfBnFmSK9d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDSzlWXc1LV6F/iMCOimQRXQfHjHMquTXRVri75d9u09gAbq8ZwLQ8c/F1FvfibXVejCc/IK4CO3zKtkdXmMHGTYRmHy3ZPpIlsB3nHgFOg+eqzhxpog94ya9YwuVhgsxm/QwhkF2b5te9C3n6EbTCZVZnf2xs9y2sIhaC9me6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QqC/Esph; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d6c9Boz8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QqC/Esph";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d6c9Boz8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C9fpbj3777822
	for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 10:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UbG04XwAubXPmna3vE6vThuJ/BN7DybPLAShgSUkaz0=; b=QqC/EsphNBDPZwQi
	hmdOM4XHdWRL1y0oej7g++dzUdx/2Ymb3Q7wQiy8FrftGJsa8ZBrLB5acbltG3A0
	IRNx4mvCekL3YU8frd76WjRnF+z5LXsFcwCBfsawEkNTZaJrq7BaFww8NtydBTTF
	v/R/EzFt03ofNMzDiIljgufl2GEM+Oc6L79H5J9pCQ5eUv6gmVB95KGqxx1l2PUy
	Z4cJvuKVYa8LJyDKNmET9iNKkseb/w5IRkVfqM7z/Dgz7q1gcco0zLRPMn5h3vQ8
	dsotr9efOn/3Kgy/7U+mx5gMpwoAbDoKSZx31h2cqgyodwMBRXf4g9wTB6UHYRk5
	zn/nfA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nucgdv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 10:50:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so1088226a91.2
        for <linux-hardening@vger.kernel.org>; Wed, 12 Aug 2026 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786531797; x=1787136597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbG04XwAubXPmna3vE6vThuJ/BN7DybPLAShgSUkaz0=;
        b=d6c9Boz8c80UM32bSniEcMksrAhA1aKuvAa4Esx/uQjpP/PLWHBNYnzjxq+77bZZgv
         vRrCNQEJ8hBPJVN25++2jGjYmFz4g8PFk+pQlVx83E0iQHxQ1AjtR4SSzf37bhD4bHMs
         qWpuIJTTL37vinkOaJczc/NyDdBwvrHImjPex7SInkN2cSlRRr8aOUHe0jNNdT7el893
         qBR64VPTPrbS7GD3zCvMsymwS1/nHHgJBrpz5jKfVyowEOCO6XifIYMK/+FO7vobM+lu
         MG/+tmy9q9Hh39jX88zhxCsun9iNcxCz9Clez/0cVVsag0eifWXnskir5/Dp++8NJvQe
         jzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786531797; x=1787136597;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UbG04XwAubXPmna3vE6vThuJ/BN7DybPLAShgSUkaz0=;
        b=pq4hegSFZhUkpUqEMBl2Tk/r/2UdSf5027w7sv4XjtAeoEoLhyBAQNZiV1yQnNvqrq
         7XP4Jku3lznzzzXh5SmLXNbTQHjaNoIKCnwTMtpmLpx5vnm2dP0szPVXS02K8iRZRYez
         UxPUgMW+ehGTWMZd8x9yVdwjIPwGWZgxpSvIv3lN5oqqexute+nuwhPFt1MaWRGeb5YI
         /DGW83/6O6kKKu9ohPPJUw0Lgf90LhRZYvTdvhXlqgyvNCrtlERNZebvM9fUaJlgdBZy
         6hLeHYQopieyxKeKclrvxIeZ2YQiiBFllCPIgd+Gm/u4+eziJoKKLQJU3XzmmggSiE93
         mv2Q==
X-Forwarded-Encrypted: i=1; AHgh+RojIzv76+qjtfcoDRy5lmcUEBSerGZgV9509wVfOrNVqZQH8oJ+68yEquIih/KWo0eYFnJsgD/IC3ledCvKkyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUEYtne58qKhLgYck8wAkxOAGxMWHWLZQWRVXT+39zwE1kuET9
	gA4Sjcw3Aj5N+QOrKop9GtJKZCP5Yyax8AJD3zo6cDak4J442n9IaaF6RY0KnIr5MjpLXYPBe7q
	yBdjmEVPrmiS3EyIazBkDURMh00moyZPO9fNfE9NaWrHp+E1+hNrU3O6AH8eR92qsJtIdJTo=
X-Gm-Gg: AR+sD10ErGSLCXtarWEJxX+DFTinWcTZPVV85u0Cnke/sqNDRDV64q9lkm+RHETAnIM
	wNPC05M1vpakspqMQVBkApJQizLUybZou2ksYSVLF+PywFJTyR3uLg6AOsn/Xo6bS7kiC+JGOW7
	HKQIHK/VRgLlXjSaPQzUeRNijjAfClOHQz/K6+N0DUxmrjU44L66QShdpsQOOlaTdt2dg39ipoC
	hiGIXFHTxKvoEGdhR0HKqsm5DZ1wcwwyx2DcxrCHlLhI1WLEdH789dxJtju0o1QW9xZC2blMJiE
	dwZ4gLXn474SPTewTAGgRJeqeFJ+3Djf9oXqDltJ5Dgrit528LJ8vtR8wXDlOVRllmdGbCYQq4+
	aqgMnf1ju0e2OSgwkifuCG6tRpz0kfCYs
X-Received: by 2002:a17:90b:164b:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-3930128c13cmr3916877a91.7.1786531796750;
        Wed, 12 Aug 2026 03:49:56 -0700 (PDT)
X-Received: by 2002:a17:90b:164b:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-3930128c13cmr3916838a91.7.1786531796248;
        Wed, 12 Aug 2026 03:49:56 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8e3f565sm3191597a91.13.2026.08.12.03.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 03:49:55 -0700 (PDT)
Message-ID: <6978a578-05ed-49ad-a9dd-814d518cea8a@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 16:19:48 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Introduce EC driver for Snapdragon X1E based Dell
 XPS 13 9345
To: Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Tobias Heider <tobias.heider@canonical.com>,
        Val Packett <val@packett.cool>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-hardening@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260809-dell-xps-9345-ec-v4-0-88306dbbc7aa@vinarskis.com>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260809-dell-xps-9345-ec-v4-0-88306dbbc7aa@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Q3YOOtIvu5nFK5NuU5tvXEEECJcdrdKP
X-Proofpoint-ORIG-GUID: Q3YOOtIvu5nFK5NuU5tvXEEECJcdrdKP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NyBTYWx0ZWRfX9omE/knN5HiN
 et1xWUkYDEa92tigndoL/tK/KrmwbcNAXuQqJ+PhNHRpx8pb/ffBz9FeMSAzW/fmF9n5BA3guo6
 eKzGuqIPhh/mPACyV0S2ylkFKbqOpueS33BR/ETjVvvo5I6pLla1e+Vr0Jon5Uy0+B2jGQM7xw5
 fGhecy8Gl0jrAj/k8T32ii56ZEOo6dPAXyTb+O+xKaePHGZFj17ikCb5xC0xTl5KmsGDR9WGmDu
 h6SSfJ7wg1FsQUB+v/ehyoTne5aVfZJm3xVVAoNV1j+gdj30xltFdOezgrcAho349MBN3sJEqCY
 Dy8y7gjzPHl3RO+i1O9uB+RPA+SWXJg3rfHTBXCBxqpXT/enWD6vHLihQ1xwLHuWVweS1CqFKEN
 3pv+ddL3jOyPVQVpTQvp/kTFzbUk/jal+3JLYmIM2lFEv7NhPD1xfXi8zy5ys6xn128qbGai+wf
 baxVBKLKCEFKzQqMiZw==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c4fda cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=I76Qk8w-AAAA:8 a=FXFtw1A4AdT0iKmZFxQA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=vUPM0Wvl0xcrLs4nqPIT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NyBTYWx0ZWRfX8J8+tWHFnbst
 Ssck/k7MlYCvRsXhJzxXPPRW3oAULBrEEv+yvu3zCodyGFfnLlfpiV6MiHa6T2nNACcYld1Xn7m
 aZ1Ab5P5FupDinDKqiMM40c03foMLdE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120087

On 8/9/2026 7:02 PM, Aleksandrs Vinarskis wrote:
> This series adds Embedded Controller (EC) driver for Dell XPS 13 9345.
> While EC appears to control most of device's peripherals, particular
> driver addresses power and thermal managment issues. Key operational
> principle involves initial thermistor constants configuration followed
> by a periodic reporting of these onboard thermistor values from across
> the motherboard to the EC. The latter then handles fan ramp-up/
> ramp-down internally. Suspend/Resume must be likewise propagated to EC
> for power management.
> 
> The driver was developed primarily by analyzing ACPI DSDT's _DSM and
> i2c dumps of communication between SoC and EC during various stages of
> operation (bootup, suspend, resume).
> 
> With EC driver in place, the following issues are addressed:
> 1. Fans were not properly cooling the laptop, would kick in late and
>    spin lazily, resulting in heavy throttling. With EC driver fans
>    start sooner and hit high RPM under heavy load.
> 2. Fans were not stopping once SoC temperature dropped, they would keep
>    slowly spinning irrespective of suspend and/or closed lid until the
>    next powercycle. With EC driver shortly after SoC temperature drops,
>    thermistors temperature drops, and fans ramp-down.
> 3. Keyboard and touch row backlight were not turning off during
>    suspend - only lid close would power off the touch row. With EC
>    driver behavior matches that of Windows, suspending device with lid
>    open powers off the peripherals.
> 
> As thermistor readout depends on pmic's ADCs, this series introduces
> EC driver and its schema, adds missing ADC to hamoa-pmics, and finally
> adds thermistor and EC nodes to x1e80100-dell-xps13-9345.dts.
> 
> Additional findings:
> - Max fan speed depends on Dell's power mode settings, configurable in
>   BIOS or using Windows app (relies on ACPI-WMI). It appears best
>   cooling performance is achieved under 'Ultra Performance' profile.
> - When the said power mode is changed using Windows app, EC IRQ is
>   triggered. Windows performs what appears to be thermistor contants
>   readout, though its not obvious what it is used for.
> - Given similarities between Dell XPS 13 series (codename 'tributo')
>   and Snapdragon-based Latitude, Inspiron ('thena'), including matching
>   EC address and response to suspend/resume command the EC driver can
>   be likely used for both, though in-depth testing on 'thena' is
>   required.
> 

Hi Alex,

> This series depends on QCOM SPMI PMIC5 Gen3 ADC [1], which was added to
> `linux-next` for v7.1, but must be picked if this series to be backported.
> 
> [1] https://lore.kernel.org/all/20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com/
> 

Just a minor point - this link points to V11 of the patch series, but please note
V10 was the version of the series actually picked in the kernel. The difference between
V10 and V11 is minimal though.

Thanks,
Jishnu

> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---
> Changes in v4:
