Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705357;
	b=PwSqjV7j6aBvOKbXbrZEQ0CPppwPqUCkFIiV3PmszHqJxUOUNDXWotM6+sJzYGbUGwhD
	 xOOpFkVhoq6fgejfq4pa9ATmBZe+P1jINfgW8WF7ntLNORUqTkwG3WxH/uaJTS1Un1JTh
	 uPn55CkA/pmxplwNCB1hey2qBiFRCmXhE4mj9hE+uE2jwa21PGouKOW5EnBk/83FjdQac
	 rCeBR7bUAIU2Nh5vDcEEvvptF7O9G4Ra66Z1UlQMFaxicoveiiyMFKdM8KZuAga/yLJ3y
	 A3mfkIMJJvPjGyrizQgMkSWXdYIoCQCmSe+pUbSxbS11VOr4xDOV+jEV1RcH34AHVHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705357;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vnCTWc79Z1mZ8LqblAJEf4ii8AcIYeMJM3mOmd7YS6g=;
	b=30w7hj1KUlAiCZBePet533cEDDOC3MDCAnlacK2rQBVxtKjJiWdI2v5akp8gMBq3YGoE
	 56jhAG0uItsoc8A1wrhbVo1m8BJ7px7sLzWx8PkfcC1Bvg73a0ZLh6blrug3bcDZVofcX
	 wK2l6sOZ8GqhRjMeBs1RTcAh+yJG+1SYZ2m/8KjHfcCX6U8NFrCb8sC02e+2Nm6r+Lj3E
	 lh5eZiYKgpXxRjEcCLlzl3+JqxvjhOU84iuKfLr6+G5hB4sVAPOiGwcbt7Ydritl6M6Ne
	 CyJxalYL4E/SrSBefcZly88f3SuxQKdz/LOl2pxe76nYP6LtrGnLIOmd7mmOWieAMZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Sew2dQp/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="V2/vigSG";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91777606B10D
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 11:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91777606B10D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sew2dQp/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V2/vigSG
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAFvN1476126
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 11:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vnCTWc79Z1mZ8LqblAJEf4ii8AcIYeMJM3mOmd7YS6g=; b=Sew2dQp/0Bsn3yVV
	VvPKV9eau7fOM4MH+Eff2mYfZkjEH35+7hM84zTqLXYqG0hMMP1jtouqm27C+cyJ
	U52q5l/SUEx3rmAT5dM+m2zmbzCxIudXMFjVnn4UbSB7Bg1qfc1+GAsCPv23kbFN
	s/ocAIN0MNrsoqgCbzDq+d/v+Yb8ZMfefE55ggXax5oqReKqDbiGil5d3qekzbTm
	ALATqVOt3cLhNnId23gaqBMwMuoTAPX8CIeOPn2wf+uf5OGB1w7GAMtKmjhgGZFR
	f480dk5QrVaKchSi3IMWmGbgxI9ycjT8Op+ycVe86wPS1iFiiRz4bbqEgLnwF7eQ
	AsPBWQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq8u5hhq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 11:29:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aed37745bcso400837a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 03:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793705355; x=1794310155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vnCTWc79Z1mZ8LqblAJEf4ii8AcIYeMJM3mOmd7YS6g=;
        b=V2/vigSGNeKvoYFLmUJX5HQi3H/u0SCXUW3AO37v6RcbYQ3VRrkHvk5iqyUbFyEyKF
         QY7mgHfKVkj0Q3lzJwniFnGuP5wBjUhe0VIIgRmo6NXiApMqyE+lRUcxEI1y1QGTgy6A
         NtV7K+zRa5QZHpzxzl1bYS3bDxm4+lno4szIrU5ZgrgDZ4a/yh08n5rIAkAnFnm75QJf
         T/0o4iLJQ79/lhW1HhIcy8Ciu95jrmMnrfoNOhLOMWaZ2ruIpDvlWhSJigBysWZDJhaD
         +NJOJxOm0HGeBSIiz4iDT8dz3ICiRX6A4BEi1IYF/1pvxLmYJHF6Fg+KSBYcCjiTJR/B
         Y4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705355; x=1794310155;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnCTWc79Z1mZ8LqblAJEf4ii8AcIYeMJM3mOmd7YS6g=;
        b=glgxAVvB4QlJZPQAbb5YE/SoEYYdBTV181IURkDInc62Mh9dqAVZXpgD6nFfxZA9RD
         Xg76KHBUVmfF030CmV0+72iqv0dWyXyTYUJh7GNkX17Erp/85D4nLCbfNlRZb7gO6oiR
         r0wIrIa0kWIHqr4Io/MwNekYJn/J9NN7qFp2flHxtXexl6ygcudO9X0wXIMfqPVDsPnS
         zoAeVQgH8riYxyJX1Af7CglqQVm1pTKsDkAk2TYesDFK0tZUyq3HEhJCfIIkWIkyfTDK
         FZTfWrgOQMZcAnC0y0CyQ6sfAJo7F+6x/HrYFs87Wsms49loLpcz8vIS9komvkpk9ebz
         elOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOnMfJMAOPOhGosbfwml08zYt9w5NY2JYti9F5om0nX5CBWGmtz+XSvJ7IMdKQmJfLoaDjXeX9e9b7X0xJMOU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FR7+KUQJ1DygKZO5jiAhVvnW2xEFOoThnU6RUy115IPpy/0QY
	mMxGAlhLkBUoT2cxYOTzrVjpvA0VNwygoBe2BvO166oK6mFCR17uNFtDJ/u7iMCVji3PHTqZ6fq
	Ue7Ce8yn2Arg69qHMZ0b3thDovzmF6VEl/fWCjJGuEj0SHPLuUzsDWbi5uHx4z4vUO9ONA90=
X-Gm-Gg: AYBFou1mBdcarP5vYko51BWHJ8AttqRQ1KeQZzLtCLpSuANmF3NoWZPh4Xu5Q54PCRi
	e8FWcM6JSko788RyuquygnRo9EMQb3b4/jjGSwJGrQfjb9/ovkrMfKNiGczZYMgi4nHcN84vxpE
	eLFBE3KE/w19hMKfhhE89lhIaVKx5DhDHj6ldOqJmb8BbHU3yU/RR6jv7AUD2tcX1IOaJcZSpRq
	Kwovkvl7d+XwtFg1AEG2DMvDmFHTRuC7Eqaecx4Idhwx13r71u9PIGm216XSbUF4AVrv/P+S4l1
	OwmXxuW3OU3trM68J+i1vIoAoNsY0pDQ82LM6I5KAlXoCCfGWWMPn+z4VRc/UpVGyFAZmyteK5P
	7Y0xz1T/UOFJ8LR1BZX9UObHwVvgbuHMWOpnboW8wEZkKBha/i3XGGhoR/35HI3UIFKfdL3Ni2u
	c=
X-Received: by 2002:a17:90b:4ad0:b0:3ae:3e9b:5265 with SMTP id 98e67ed59e1d1-3ae897585bamr7146008a91.26.1793705354443;
        Tue, 03 Nov 2026 03:29:14 -0800 (PST)
X-Received: by 2002:a17:90b:4ad0:b0:3ae:3e9b:5265 with SMTP id 98e67ed59e1d1-3ae897585bamr7145979a91.26.1793705353952;
        Tue, 03 Nov 2026 03:29:13 -0800 (PST)
Received: from [10.206.111.19] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85cb91e5sm10519214a91.0.2026.11.03.03.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:29:13 -0800 (PST)
Message-ID: <bac09735-4136-442c-9208-556568d39967@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 16:59:05 +0530
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
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com>
 <20261102-camss-isp-ope-v12-8-702254689feb@oss.qualcomm.com>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <20261102-camss-isp-ope-v12-8-702254689feb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mikQI3e2HJtZ06wMcJcDnfjVFvaWr_GG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfXz+idoWxpHGYI
 7Q+nnumgyRLY9mfbaf9VBVoAN78JXXaaROoUlBkATfaqr+C4Dj+OVry3CULGyn3EPmElBgE4zhs
 4bHGctlTLyrXlNWgiMAUqgtYxfdVYpY=
X-Authority-Analysis: v=2.4 cv=RZ0FmFtv c=1 sm=1 tr=0 ts=6ae9c58b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=sEFLFU3R8KEXLjjolHsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: mikQI3e2HJtZ06wMcJcDnfjVFvaWr_GG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX2McsugGtu7vP
 lzD4+NqmJWgedcwWvqyVIygdkiGa8AbqKH2JvHLfsMw7WnUv6XhIfIAGfmW21N7oOcaYC1q3now
 yn8f0Nun/csj7XGT6fmntMZrwXTU0Sbuoeq10j9MEB5gwnEvqgp8JUaVQ/NTbUO3Ch4Z4Nw/WEg
 w+XOQsM/JnUvdHpEQN8ydqzeomRIt2mKJYeNQC4lrtiJY+3iwma4rjAMT4BOmQAK97UWWBQcHNE
 v0eNZH5rFq7qxIpTRnobFnYBY82tNlxTpUQ3J3QWyqZuRAOoydFl4jzItd4Qww70/FqPIuRJuN7
 nQ4Z7MwzZVM1aefI4Bl0rXMybkZW3c+VVlDMoULAttxz4ihVqAUVoo3mqCWCJpDIm3kL5q7bWb0
 DCCM+AZ6rc8XVa1DYigx/NwQpBtJC4gp6xKVG7DUeRZnQWxNMcIuM0cLLbhQXzeRI1H1HMjAnqm
 dfwFGZdZtyZCc9zu5cQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045



On 02-11-2026 21:17, Loic Poulain wrote:
> From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> 
> Add the Offline Processing Engine (OPE) device tree node for Shikra.
> The node describes the six register regions (cdm, top, qos, pipeline,
> bus_read, bus_write), clocks, interrupt, interconnects, IOMMU mappings,
> and OPP table.
> 
> OPE is a memory-to-memory block with no board-level dependencies, so
> the node is left enabled for all Shikra boards.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Tested-By: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com> #Shikra CQM

-- 
Regards,
Nihal Kumar Gupta

