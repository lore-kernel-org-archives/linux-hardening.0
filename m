Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522950EC17
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901910; cv=none; b=OeYu2cT8wvV6gJU/htkRcXqBqmiH7e0gLqvdLf1xb4NMbdpnIqyPoeNday+XBI6vs2v/k5/EpyGDRb+HmFC3fFgLq5y9yC70MpCAX4xzk5vAAoPC2Tb2+lMvJGq8LE1JIo+JEwUNgtvKkyvtiltOmyGwXMsQDBHJ9cW5LgFWeu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901910; c=relaxed/simple;
	bh=Xc6UXng5AfMa3Tdm3xgVuHWrr4sfMoltxMiAHnxmBU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NycXfwHgSBOtOaBhB9u1bQcT7GPWe6lP5l3yuBa2sprgTd24r9aMU4BWnyv+u5tQorkMcFTsu5gdjEHcIorMySagyWj7JztMZhoUZ9C1ifuhwp688JCFklgUcEABDuuidnGGBXj8DS20Uy91Rh7cjRX/Pmm1Vy8cspJWDI1iLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WLZIH1D4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hs0SHoxF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WLZIH1D4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hs0SHoxF"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE3g9a1143678
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 14:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/YOqxGlLfUnOc6Yx8cld+aJVHshZXI4bRKRZq6BJB5E=; b=WLZIH1D4gmyHOg/k
	cBYXf1jWGHJIcH9nlqKa/CSOjlWL6EDg0uiE6jPkwbcE2szL5VWIFy73EM8UDLdI
	Jkz8PVhdPQY2daA5dW2FHefgwewHjmh8PpVKN2aKgRQ/v/ObUCJSY8jwoN75aA08
	yw6tBPiJYpflQn+kXKugwDIjlU7OyrYDVWDG3ck7P0b0Cqs4uPkCORrC4iVlN/pm
	jqDoDj7eExStvPkiVWY2oE23F+oxOMIpK/PbYamPnvsNrvb3jk40vlq6b4ZXGkXw
	aOXpUnFV6JTuVgmg4OdpMM1TabUilDCXQthS/Y/68nALCHrizB1lF/WLEzIWpfWY
	07BOPg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hpg9c2y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 14:31:47 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5e24d542d40so3748678e0c.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791901907; x=1792506707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/YOqxGlLfUnOc6Yx8cld+aJVHshZXI4bRKRZq6BJB5E=;
        b=hs0SHoxFoNZhCTr9ba7f9r0jw906VQhwQssz13Ur0/2z2kM0wg2i5Lx9Nq/GMZp1D6
         ovTKz4+DY4n5FDh2nbqACDDXRtyLI3PZ12ghFRqFxP44a6RIpU9njwtR3nUOethhAnz7
         6GYlpUGmNcoliIwPvs7Igroy9OKpYYm56RSzUnKQVQ6+gdxfulhvBLUZtpHCK+IFFOQV
         79iW9eg5iWdep5X8ZWVS7W5Z9kS0erEMUp40nnp5XBQY6AyM1C/xiceVbUWQbJUUhMHW
         QSZfBgGGDeI9rnnc4ikW6+scxJHTN/8Z8dCTiMpMK5rqWSzfYIhYf8P6SCEsrtNqxYIE
         /1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901907; x=1792506707;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/YOqxGlLfUnOc6Yx8cld+aJVHshZXI4bRKRZq6BJB5E=;
        b=T21lxRr3oDrfkNAMFMQgreFU2RNE5G6rD6E0+tLYdISBMI/ay8QXidbAJKkuXVWxWI
         ADXNJNB8oncI7mG2p6BvcnIzKBX3dZavuOk+wQj10FFW2bxTeoavn2br7UxD4EdohbpW
         FS1g7TLhBKpKY9HB8Cj6JsgUNZSrXPIYZm4M3ccZgAyyptFcUbi0Oi6INShhIO2dPR4G
         1KV9XzdloI5wC2BLmCuGjBDiWZ9GoT+poXbNReQ5MJ6zrv8Ylu40L7wHam6JWYZI7LzF
         yHKlmCviFeAYxmy6Xz1ftGNrRP26nLU4z9rtI1cEZVdDt3mAkrsUIGkzCzZ6vrXckBhf
         VfFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOx6kEQAEI25fxh3hxBbVAHGqaWpxoyCkbr2SaExh0y7PnxcR0xpmB7FbtSj3lUv84CJzsjyi9AKfI/ImDgS0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIjgLyCNqIav7ijiQSBWO//tE9iFpdCL28tYbYfMsqlE4DnO2l
	Gwim52ovkjLlgFcVKBY3TtNo8NlCj4qc8wTD4QqORxt+PkOoDwp8twjt7JvPuYGeo2nIxja5jC/
	RGrBiOw5oVQBQL0LyWOjUxyAjuguF+Kw7nGbUZFxacC1rmQhPKcCeBUsdz3jeAPp+xRe6Seo=
X-Gm-Gg: AYBFou2n4CVEwO5PQr4xrWTaMrXgrDRsQplUBwuBeApJK7qaImEVIhMb4AGQX/JmFVP
	rQdGYF79T6kaazwVlDkUxA/08HgBiWXTcALWQywZ28EhvysHe41w2I2PAox8AqgQNoNvIwTOSqF
	RIsUhyngIesPupXcTdQrEO7UjHRNRDQkBFpx75Z684A6RG/DXqP6kwX5AvKatAB4i5TbV/C1a+4
	ah0Gq9hyP1v2pEG/5girOjL4KtQVSg9/4SRn2o2ITZj0tULsQlE7wGMJcire25n/VhOuFtEKfN+
	jxSi8kaAl5RXMzK9XYCYgrExunpvqVNGAWo++tqESDvuxdfnR1ClPuj3sXi3zmRTc/pIXS1f08O
	o+tLxBKTVuC3155h3
X-Received: by 2002:a05:6122:6161:b0:5c9:a60c:2732 with SMTP id 71dfb90a1353d-5e91f44e07cmr4248144e0c.10.1791901907045;
        Tue, 13 Oct 2026 07:31:47 -0700 (PDT)
X-Received: by 2002:a05:6122:6161:b0:5c9:a60c:2732 with SMTP id 71dfb90a1353d-5e91f44e07cmr4248001e0c.10.1791901905853;
        Tue, 13 Oct 2026 07:31:45 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.4.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18beacd2csm401121635e9.14.2026.10.13.07.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:31:44 -0700 (PDT)
Message-ID: <04a1331f-1375-471e-a674-87039aeb0328@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:31:41 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101 TMU
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
 <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
 <fe159792-c58a-46a9-950b-6c21d2172601@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <fe159792-c58a-46a9-950b-6c21d2172601@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n-XYWSOt8xPXxpdCfPujnvGzn69_R2nJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NyBTYWx0ZWRfX+gDK1xgi43Q0
 MhXXrJpzARVu7Rf3CNPHpPo8DijXNCe28WGsI+sYuJWIt2dVS8EWzVMgVSJ0+O64IE67lsmhIBv
 FgF8ptuB7uDAHjmUUzPVE+34S2SyVso=
X-Proofpoint-ORIG-GUID: n-XYWSOt8xPXxpdCfPujnvGzn69_R2nJ
X-Authority-Analysis: v=2.4 cv=Z4Z5j3RA c=1 sm=1 tr=0 ts=6ace40d3 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=Pwpi88Ktxb2v7RWwfB9ReQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=GpSJM9idUVmPmik-TdoA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NyBTYWx0ZWRfXwMXYi2GszSnR
 1rze1w6ae7BLc1fnsHsk7Mct97XzNCciqO0/lKvZjZlOKJj78oSZTrt8Mpz8kETUrrsd7OoJCw8
 xJ/KLp80mimbN63uPFx7J3TIhjw5e8oeRoEQPRAbuAppWLZJFFedSqEtEpjsoVssrhue4yxZIvj
 ytuhRH6BRbjtjVnSjXvXw1RTXxBp3DtfQMH5/K+haOACauezvBlzw060vpEbnVB2ox8AoUv7JRw
 dCY/qgWTFrSkjhXvN4M/AShIHhXYf7+9f4mDO8BdUzAhEo/ES1oGa7FPapwFBqYPV+sl8O8qnxz
 HJirEJPUok/oyqTPbkqWq7Jn8SVqKimEukmfFZAijPCf0rw6TV0nvgeLnKsUEwl/hAwxH5dHzGd
 Az7UVGE+8fLc11tTGZ+Lv26Ip0nBdSuwIM+7w0y1p0guyvpInG8PE3z6cSqOU27t+hi8fcOq76k
 eV0ZeCtmdvV88Z4dbfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130057

On 10/13/26 16:26, Tudor Ambarus wrote:
> 
> 
> On 10/13/26 4:33 PM, Daniel Lezcano wrote:
>> Hi Tudor,
> 
> Hi!
> 
>>
>> I noticed I picked up your series without notifying you
>>
>> However, I did not pay attention but picked also the dts files.
>>
>> Shall I drop them ? (AFAICS there is one comment) and let you handle them separately ?
>>
> 
> Yes, please. dts and defconfig patches shall go via the Samsung SoC tree.
> 
> About the driver itself, I was about to send a v9, where I addressed
> some issues sashiko spotted. Do you prefer to drop everything and wait
> for my v9? Otherwise I can do incremental patches.
Well the v8 is in my tree since a while now and I'm about to send a PR. 
The patches can be dropped but the v9 will have to wait for the next 
release. If you want this v8 in, it depends on the sashiko report. Is it 
minor or major ?
