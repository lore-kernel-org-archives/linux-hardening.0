Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724462;
	b=rV7O6lH2kcldJYRJf8JZDNGy1HflJjT40r6niW9LepLweO/Zvj276Hb8b0NYApKHYP4g
	 62SIKFIhxx2Ka/14rDtuL8atawT5LrIr7hp+GEIEisf4aa0FlK8d5PU0HBqy7zr3vZZkr
	 xwHX8aoryZV84YDpKBr0eRmWZ8SORYJssR+y5qa8qT/tq8DsfK7Y0UGbcmqfmz9LyJHdn
	 qHhwJK2+v3P4gEZ7BwO79nzR8kCCYBv4Hh1wYnVOpre6a03p0wwvLJQHRxiNJfR1GDbzh
	 EksFNDEEjq39XpBVylyJSuAfNZyKDKs3r/BDcyni+kF9cOxSI7aGPGcTHG3qJdUQjdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724462;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Paahz2cu5Q9vlGBYGrknkFs8wYwBWIJPZ66Zms3vNmU=;
	b=KGCTC6ikXCLNwZSoVFg0hB4qTw/UJdEk/ZKvmxkYkoUC5RqYpuqV/mhOpRCcwYHdkuTN
	 SNcU0TdikNO4k7b2gPiOQ8Q7KjMKGHKL94Pp8IiiV7bcTv+HwcvV3GJVfmdX0qDnbA1xg
	 N2ZGpvZjiHNMPTMJUhg8DiOyMRPIOLWyenZg39PNm7GDJhmhV95VjQ3rpEL0G1vLS5udy
	 6I5/ZyrFXuWwh6sUv3gl03KSVt0WPKuceXi18eyi0sk5qrEY+HMLdcwzaZqOiZILa+PAi
	 DcmldpSe0XWySE9L/bXJKQb22i3tYcF6dTF9WVEvM8+Z2jHWca3BF8SIJ09rouaPtKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bhn+6NiQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GustMljW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF8606A328
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 16:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFBF8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bhn+6NiQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GustMljW
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EA3Jq3657791
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 16:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Paahz2cu5Q9vlGBYGrknkFs8wYwBWIJPZ66Zms3vNmU=; b=bhn+6NiQkuOQKXG6
	XR2m53GsSTThmw+w27tl/BJmR4EFjS0irkF/k1h+e1fkw3OdIxc71YE3cT04Wnq5
	VLq5MfNX2Zogbp1rCP23LJcEhL0EYKx+1dg75LRngxkznojXxPkX9Ig6KJ4cvH5y
	CtETC/QVuj6CgNZt779t3+4DCN11aPXiv5ofMqy4ZZb/PPvQTC/ym35f16EOivP1
	d32nmGAA7DwvnGJmjnDZKSyU6jcP8Mr3liGyA04Hpw5fJaJXGObmClAcSKhSDdfd
	at+XJYYh9vg48qwb/U9YL8+VIUsDNHoX+q7yFDTZTFZWzUnlzhIdPuDcwHfNLbFe
	OiKh0Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq94ctsda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 16:47:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a065e2933fso5079942b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793724460; x=1794329260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Paahz2cu5Q9vlGBYGrknkFs8wYwBWIJPZ66Zms3vNmU=;
        b=GustMljW74EyHYAGxYnZJlmz7VB6Z7HF6zWtTvun2Jan967g7FZKW+2SDHqbJnm7iY
         V2wG7rQpR75Et+VAP9DAfCP0cBX3XEH49+ro+fYD9u2SSewjW4hffIUe47m+ujzsq5Gz
         ROEjh6qyBbbEOLAcobLucguM4gaDJjITG/fReHcbEWYnFSo17nuW8VqgPy82rq+KCuvW
         uAj76L10GqPKH9lK5uV9rfm6Kx7NIux3rkW7bG1pu70mQiNEnXcA9VBFjyLnQ2xGZeIw
         jlfTSCe3d/h8M88U4Yozk7tqhJjasfsK0k+XPljafncPrK6FA0T5RZPAEKWN1qCDqGsv
         CTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793724460; x=1794329260;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Paahz2cu5Q9vlGBYGrknkFs8wYwBWIJPZ66Zms3vNmU=;
        b=1AGGYGg2toi48cguYL6Al+9+Lrqd4HNm/O+GGKV3e1alPZVn6m2Y8ypS9LLs6ekvkF
         BYv9CYhMfpyIN2gvhEcHWDX/re1DickTDwtx0LjyAYYEoQmiD/L1XKcccX9R8lfIxjfI
         V7uhw1VKpIAMYvCb9cibnmGiE6dpdaHE+Xp8ZjrgbwUmItx0Txs1GojWy/BWCmqfhcWD
         axCZ10dKy12GO81E+isA/ThK62BMnMDq6bIBb2WephWmuNb+59hlWCzRSu7vlyYGNxZy
         2Bvt12YUL4PhKaFSGe+OoibSyEWYja1864dTnSCeOJQOzyLiX42v0/GtNJtTxMYg5FEC
         TakA==
X-Forwarded-Encrypted: i=1; AKwUvBwvOZ9aJS5w0p8ObC4c3w8Ja4Gd+a4vdnF4XLsPk7tKZj33W8iJ8dN8f4in5wGO1+mXxfmyCdQSY+HY+hl/zNA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8o45awBo6ZMfyntCtse4L5F69zBYBlffini5E92VEvHbzqVKfV
	EYpcNyWZGbVsSqLoPWWPrw2RFuDpArr6GgIficj+BlSDBSR5bJl/Eh5OXBEhVIP2E01ODcGFC/8
	ilMb1s9StX0BZUUL/Zx2vblnSE0vIwHflHyz1PO5dhMmPzyuiDva8uuYTTVobg1Yc/GC9XBM=
X-Gm-Gg: AYBFou3lKUsqZLPwfILMwtiIIR0uKPbPNDygTdVYeMH2TTLkg6z1M2rfvmHKLzy5kyW
	NJZRh3DuvBW8rauHzy3OSy/e/ubnYChshI7y39UAImov/yWzgZOEesbpU161m5OHv3SEzLqQHGF
	jeokVrmqYwfEDTHwnFzXXfdv2V2a1eXOXxhavkcZgxzAknJCWt3mvDJYjcabnwSBv6vqo3rH4kW
	g2Vge3zHpj7S+hKoxZSxmWkjdxyoUSm04wKPfFeRctafYHNIwMfMSqIA/4B5OUaSrQdZ0C4+TkX
	DUynkfXwCxcJHnRiAPgGURlN2YOK1tgVNkliIBCeK3Jr0pyptBtMfKtPGe15lwTGFZjzFGjBAH+
	UIRYFQvXqckqH2GxEv8sQnV2ur/jtNmyVZSk6F3RR1bJuHcrNb+cElQy4UHUZGYNy6mp4AvMK33
	C+
X-Received: by 2002:a05:6a20:9145:b0:3e2:1160:6d20 with SMTP id adf61e73a8af0-3e928a80f31mr13008324637.3.1793724459662;
        Tue, 03 Nov 2026 08:47:39 -0800 (PST)
X-Received: by 2002:a05:6a20:9145:b0:3e2:1160:6d20 with SMTP id adf61e73a8af0-3e928a80f31mr13008297637.3.1793724459204;
        Tue, 03 Nov 2026 08:47:39 -0800 (PST)
Received: from [192.168.1.10] ([115.98.177.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d3603sm3400303b3a.37.2026.11.03.08.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:47:38 -0800 (PST)
Message-ID: <ef38c950-5fa4-4b57-b97c-8f306b2295e9@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 22:17:29 +0530
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 8/9] arm64: dts: qcom: shikra: Add OPE node
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
 <20261102-camss-isp-ope-v12-8-702254689feb@oss.qualcomm.com>
 <bac09735-4136-442c-9208-556568d39967@oss.qualcomm.com>
 <zymjeclhd2ezemd6jeujtsu4y3gb26gi2v4vd3gmi7diuaa23m@aqr4blf32t5b>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <zymjeclhd2ezemd6jeujtsu4y3gb26gi2v4vd3gmi7diuaa23m@aqr4blf32t5b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O+KsLx9W c=1 sm=1 tr=0 ts=6aea102c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iaXPdgsK/hfklW56b25dCw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=DwxOReZszbjtibhM6OkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: RHDoLg2Z_MMgJb-qE4qqnwBppzowQMk1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NiBTYWx0ZWRfX4HGoOhsCPBR2
 8SEWU77mCVIqX3kUyrdR1ptXls3bTegYeGuyKwJR9hqppMo3XcILVP5syb1wV1kHGgdOr4eHS2c
 BLmr1yGp8Kf0WF/E/yYgnPO/70/WynIPggqAsQ4qEA2vtizrCF6FDdVeNR/B/OAnjdFkJWLGB2r
 z7sZRQmLYinQfp5foPHup9iYA9v8d0tXneawMq3PSCBf0v6qsbx6Ifnlg4XvgZBCzPof092yeGQ
 YbGZwSLK0IWcxM/6KG3R5Qahvc4P0hPRwILcyiy6th7lJ9vuO78p5FJzFflvdhDSuFu0DkYR9wE
 mJEUEo2QIHftw6+lY5AP+T3B4gDjnnjKFYkQw6l+kCwxAPzA1QQplLKCxJs334FiAJyomqP6kb1
 9B/ndsXQLZOB30YWrpnBIvcSciQp9lB2EPdUpS3zUr+mgrSAyHy0544bMuZNnFLS9sJUVHECir/
 kmVpclpm3kOn6WJs3Mw==
X-Proofpoint-GUID: RHDoLg2Z_MMgJb-qE4qqnwBppzowQMk1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NiBTYWx0ZWRfX2EPC2yMX6zkL
 KP46FGaZRRLkPrmBzXCGm36eHwyO9727ffMCwwMtqIfBrT18AV4K2gcvgw8EDNy8V/fwlJdjbN8
 yTj3jCshM8FijT6g9mIDCZ4pBuZmFNQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030066



On 03-11-2026 19:03, Abel Vesa wrote:
>>> OPE is a memory-to-memory block with no board-level dependencies, so
>>> the node is left enabled for all Shikra boards.
>>>
>>> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
>>> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>> Tested-By: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com> #Shikra CQM
> This tag will probably not be picked up by b4 and it will probably confuse
> some of the scripts maintainers use. It needs to be "Tested-by:".

Thanks for pointing this out, sorry for the typo.

Please use:
Tested-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com> # Shikra CQM

-- 
Regards,
Nihal Kumar Gupta

