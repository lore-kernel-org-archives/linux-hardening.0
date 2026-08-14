Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52462438FE4
	for <linux-hardening@vger.kernel.org>; Fri, 14 Aug 2026 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713269; cv=none; b=AncWmHqb2LTg3T/SS7b/NispsLj+o6Lyzt6s/TN9abCnAM7eBDkfKNPHUYtIdSvVtmgEZjwPhdhz4XUqMjmrtzx4aq6Vs7ct/0MzoSh/OsRtIYYsYp38WM28MicBsxaoWsxf0Qvq4fthtZvzOpmiuIZ9CPXQF3A6LMjSwESJ2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713269; c=relaxed/simple;
	bh=DeXrYOF1Wymq7i6AG2t2RjGNTPwbswPu0A2UMnwWnG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAhH0lfwg1wXsq4EsmoskHx7BtFxm2u4ZdaE3ZrJNqyn969ydhwsH8LmSAo2Lz3sJ5Iw34/fHinx3QnkW2l/ZrHXVpcChK1cYmNiFqW5C0D8nh0ElWqld3JipyBr5zk/hXSofnHGcuW4XB5KjXNahTjodkOt+jxL5OBkfjzzkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCE73+N1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UCCiupWE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCE73+N1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UCCiupWE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAbAk22555678
	for <linux-hardening@vger.kernel.org>; Fri, 14 Aug 2026 13:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vviloqTvq3WKiFKD7ZKd1dUGZvDqcy3SN6oDPTL/GUo=; b=kCE73+N1jcjwYL1v
	1NLH6kaopfSYnyiDAxEyMWBypQ5ncYrAPKVN9AFrxyyAQwikfI/TeXh0x5+c7e7N
	eEmpGdOR8dQ1w95X9jTl6sJikBQPiX8/yKS855k/QnU2Zk2LxuYeBziPeOrXn3cI
	uWMHlALQyGOyv1rBlCj792HvFYj7d03jLiEbZozTxIgYNEfSeUXi1SLWPbz99TkE
	3Ly2uaa8lpCCLrSABZSKx6B5YUtxb6mr7wZYnT8s8iWLjlIBySWB9Aegrrlds5P9
	P9uxd6rJG2g5zo6eRwyxCuJ8rdWhpzARbJaHr0QjafZ71u7UWvolQytNd1qX3Wj1
	DdpnAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g20sj0sjr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 14 Aug 2026 13:14:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936a796a23aso92208085a.2
        for <linux-hardening@vger.kernel.org>; Fri, 14 Aug 2026 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786713265; x=1787318065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vviloqTvq3WKiFKD7ZKd1dUGZvDqcy3SN6oDPTL/GUo=;
        b=UCCiupWEMpt4O//wo9T+g2jnFt3EOXgcPluCmia+DBZ8DgwHrhAdfzGjtd6rWK3CH1
         Xm+aru+7rd9KbuI5WrXId9uqHM6joAz5OrQQqgLZAlEesyIZbxvpSnn8p9+VzcFOnuE4
         RMBa3IwRosaffBTthcpea3Sxq2eqcV51B/l9+EuyR5tGGfLXqqYLvzs8VYbSKzmW4weL
         EEL8+oHFqI0kXJPKkG/SSP0BH8Nz8arEbZPTPLevQrfGQIkMuZQ3RBfLVLghXatxxnH7
         pOWrjf+Z2naDc1GG8Xiw+QJ0W+4go1H0fVtf9W54YIUYkkAFG19dDi9dZabp5phuaBRU
         HjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786713265; x=1787318065;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vviloqTvq3WKiFKD7ZKd1dUGZvDqcy3SN6oDPTL/GUo=;
        b=hboMOwnQWPQxw0cswFWtnUC1MkB8JHG8NWyiKMeL/bUq77gGZ46ukJd0/eZwWRK/Xj
         aKl42M0Vb8vtAMcjw5H01OHoC5y8b6RfkQWCD7gxBnPq/AV1151QJIb8k6Ttf9ESQxS+
         k4PR55Tv5DAbsGlS5zvYIGRsnc76hEDUMxEzz+rbACjo7PZMi+XCejUnSHA8ABuAuZz8
         WeoOu4Uy3QFBqdwyLDhsDoe++v1arfF2uIDFNmA/TkC/l/r07LQDdMD19cuUjSDwpT6Z
         lcKbwHkmtRSIQK/AsCMrZfST+e9p+fWUkiwW+rniSh15hA9BKWGcRj8mSKr+Vna1d9Kw
         rorQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyRyj1GyR07XRn0vGZtIQguzcxBC3qrMOmsYwBFRn7B55qhnzVITKuUXksS8CXIin313kwH9DCUJS9oH3A5Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweH2E/dRKcLTvrNQk8BDkUhgFyZ6ZQoQt1DC1R6B4R3u7bcxOt
	HdqO1JvNqCRymtNdsMJSu+LIdbc53jdywJzr4AKpi9hB75z7I9R29svKYy+RmqCWCazDesuigHQ
	1R4Xf5Y3TlEqrz+eLcsJ5mjpnixcDv29mcLcEjfFUu4W7c+beEgABbkgFhrCwtMBZgXUw0ww=
X-Gm-Gg: AR+sD12hsQXWYWRFwA1vg+5QJSgSRkjeXGc6ryVGQPq5hRCPOPv8TLWbUMA7liGCRdk
	TZCHhxKUYHepEb9oITIeOQQZ0jEJws4CBkUdsTgnYZdoGehbsIz+j2sIZOSe1xzRCfHdDwnxw8s
	zjahoLCMSvgdTNDU/W982imOY41IUtGIAxkzDj6gU4+4VSN+7Z7cnzDyBCmPeOS8KVgRlGN5f9W
	4J2e9XJNIbWa83Dc9mwfg3eh4HG1Y5XmS64WfXCmuFr3fEF+lyGJ2qOBIQo0Jub90hxSlqx1b3B
	bp+HnkuKfcgfXDKtr7FoM4v5bzYB8AUppGOi3BD3ltgtw5bLnYNb55OTiQbVR6Fzuxl+r3BOOM2
	MgFaCOLDDi97Q5xnKHu5RS1dTQN+jrvt4HEsh/oT3yXQ+XEQKPc4i3EbQv8+4
X-Received: by 2002:a05:622a:c6:b0:51c:15bb:b4f2 with SMTP id d75a77b69052e-52d85501022mr56159871cf.27.1786713265405;
        Fri, 14 Aug 2026 06:14:25 -0700 (PDT)
X-Received: by 2002:a05:622a:c6:b0:51c:15bb:b4f2 with SMTP id d75a77b69052e-52d85501022mr56158721cf.27.1786713264841;
        Fri, 14 Aug 2026 06:14:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e4c:e833:9d1f:4e19? ([2a05:6e02:1041:c10:e4c:e833:9d1f:4e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899753ccsm32150965e9.0.2026.08.14.06.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 06:14:24 -0700 (PDT)
Message-ID: <8e82f564-be0a-4bcc-a9e1-72e0d26ca0f1@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 15:14:22 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101 TMU
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
 <DKNSMR9KRFQH.3SQDYW46B42FV@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <DKNSMR9KRFQH.3SQDYW46B42FV@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEwMCBTYWx0ZWRfX4gQGedKw5/Nu
 0PxvlNNpKV21UaZy9ldeTG6UdlB6nuXmdDDitsEUXN1fNVzuRI0ER44JlPVUwm45FYQFpFVy/sj
 4LgVAyCq6A3uU1hQvWd/PKyjc35lmVdEr5D9aiIVg9w1wCVOll11xY+fzsb8b+PoPoTvBDi8aIy
 qTIfmCUIsIBrQZr0UMXAOaTgElUFTuBE8uvP9fro/MUzLQHY740uF5fCs2c2R1mNlUG31hdJ50b
 VxuvDKHrsJIBMz8KHZiJ7AUuW8vP6ouNRXfx7klGWJb1BgqDeis57KITgQ+vxJfJMo9Ojgb4WUF
 5dDLToGEgyQ4HyoQKFHkL7HjwS3xH3twGOcivXj015OWWZFBqntNFHy3oaJwV/rkYaJz/fD6KX6
 LlawqT5cHDq1Cu01v/qU9I3z8TNGK8eoIqzlSaKkiyucD6/WvgelqJ7SfSSfyXqIJ0r4g0szoES
 LCiS8X4WXOtaeN9z2lQ==
X-Proofpoint-GUID: -q20n6JuBgAy6EHpnvyZ2kXJE3B3GElE
X-Proofpoint-ORIG-GUID: -q20n6JuBgAy6EHpnvyZ2kXJE3B3GElE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEwMCBTYWx0ZWRfX4PA7RxTlpYdr
 rx6mdoWescOM1OEdfbKH1o++IrrO9MmqDdMh5ToRlKbbzqdkkFWszNDpbkeunwQETjo9oTswQeQ
 MaY+oVtIaYYLV8mLuwZkLVDLpX2bqRc=
X-Authority-Analysis: v=2.4 cv=cMTQdFeN c=1 sm=1 tr=0 ts=6a7f14b2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=z2-NpXgQeZIsa6yCj1MA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140100

On 8/13/26 13:52, Alexey Klimov wrote:
> Hi all,
> 
> On Wed Jun 3, 2026 at 2:00 PM BST, Tudor Ambarus wrote:
>> Add support for the Thermal Management Unit (TMU) on the Google GS101
>> SoC.
> 
> AFAICS there are no new comments and no updates and Tudor said he is
> waiting on feedback from thermal maintainers (for 2 months now),
> what's the status of this?
> Apart from some required updates [1], [2], is there anything else should
> be updated here?
I did have enough bandwidth to review the series. I'll have a look 
whenever I can in the next weeks
