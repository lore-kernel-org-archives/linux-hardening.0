Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E783E5594
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371364; cv=none; b=ssFV5MCpp2dm52vH93y9eEZctKfy/uijFubPxXF3i8yOY7d2RhbJmaFqOv3RJujv/zrybhm1faV3hzs6t42+g1I8BjXSCLrul8nSISLOL2neiNwEP1D22RkiYUlN+gF1CvLyS9bbN9cHfSv48gzeTQwpCOgAAznC3barYXbP2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371364; c=relaxed/simple;
	bh=MvEi1EsRK25OVuV9Cq1QVbl75Tn+alqX625QMrIWFwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5DUhda6sUtGLaPFz/IVlY8J6b1F7cQvj43F4g7rsqyV5YD3/FQ9uPFVgII8EvbYbi4ZGA0TOQtG9mEfgvrinNIjhfslLd+kUS+IilT/oi5e4O7E+uWBJlsPwyjSv5ZXBW9/4KtP+Oo+t/Lg3cfT8uslcerKSduh1wqjfChbe8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IMPm6cXv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EPW1pYTQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IMPm6cXv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EPW1pYTQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7Dhpp440970
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 10:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DcuhAahfQK1r6Ves89P/ox+ku5EwRsjL3bpApW9Nzm8=; b=IMPm6cXvF7q/2tO1
	pdSAfsimIB6B1Xbd+JqIPJTE+OqA0Mo18HNHLzcV30C1WJn0P9/s2Qt4bCsRt8C3
	v6T7JRXNELV6z87MILDIGU71QTOFI7zFrTw/YsOJYt9y7aeP17KV3XEukTi9e2AN
	h6VW4f+azxqg4hJDchM3X4R69KhO0GTE3QJMsAIFt8QlYeQydAifr3IVsDCjwts9
	GCIAmuiVxn2Jkc0o3i0Dbt4bAtqRoyc9ULXz+6eZZkj6qRJqRt9RXACX50erP0rt
	qzZhEboZWcMw5xnPtMJf7JQpUu5CEwPGG2xY7bq24JNa7U5n1/BECB9nTEB8IqKx
	khAmcA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac43w69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 10:16:02 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8aca4966fe6so32885866d6.2
        for <linux-hardening@vger.kernel.org>; Tue, 28 Apr 2026 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777371361; x=1777976161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcuhAahfQK1r6Ves89P/ox+ku5EwRsjL3bpApW9Nzm8=;
        b=EPW1pYTQmfTaOliETu3iqe0s1V7dPgZRSYE+p8Hp/1o+PRQH/EGj16X1+QOTPrIiCb
         1Jg6nmc08cQgcwhPybvOlCkRjforu+U/4c1F0a7F45IGyImoOcKMopkcZuU0zi6xcdwK
         2JoWUmF2Ty7IFfy7vEuRt3gqeYgxjqbdqIcpHJmnd9eRueYZZQkQmKYUUOwce/8PWQPF
         XW5wlrbsEwDSBdAkRR0VXKNxVpYI390gxVCgd0UBS84NscPmJJOciCBruQY7IfgOexYI
         uJcph3HT4Qklhm1sZaRp7/SfVFi9MkjTd/hsyJ3AxfsXEcle2jgNFzncAfonJiqT0WhW
         Bb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777371361; x=1777976161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcuhAahfQK1r6Ves89P/ox+ku5EwRsjL3bpApW9Nzm8=;
        b=huYAcjM+jfyC38VMJv7mvc0zJgOby5Zw5klVa/ztx3+FI9XpvmEFmCVJV+OyxxJ4Rp
         pKlqjQ8fixw53m8O6YLYCck7Hg/8Or8ul8W36TRBhg15Bswk/RXSqY6mvtmWv/mbf5uQ
         Cc/tY609484AyNm3gUqM6dGDFyboh9rH6/Q16TSvTa0fKreSOL1LL00+gUkI2wUGNwlr
         TMpSTZsQ98bQYkFGBDoD4gorBsV3FHIZA40DmXn6iU7wIu7ITr6JHPJ3a9eQmUgsObVM
         ENafJ8Od/G+3aqtT3+4IjJCWotnQ2lx9K/r1efHt4KH7ALMP7tLd12VYurhw0dO/MYaQ
         RQMg==
X-Forwarded-Encrypted: i=1; AFNElJ+2YWFgoreqHA6fnmuEuSwtCCapv1bbm3B6+CdSxv/gwjHyrX0sR4Bu/DWJydY1u1Rmo1wRhX41JnDHtyGuUgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpk9bCEOH14ZJ+yGB+PTbtDabzwrnIXKh38ELUyonMH3KcDhUv
	QZ+D4ZlAyRIlsDqBUMYEIU4RauTSPFR2XXIMzT6oBurcJZFu+w3iIsFoxid60k+1zWbeHI7iAna
	9rb/F+5sq6WPpcgqgtfUjqfLk+95pWqjYiXCrvYZkhBtOj7nN0U10AFJYn3tvLKu1U+THX1o=
X-Gm-Gg: AeBDietpHaWp0eG8ZT8FY2qD5mZ7XUN6scIp00TGbu2SlasdOUNv8IKpFhvEKH0BQSI
	UdDZE2yXCiceJko3RJNMpK/7sxhniCgUDgaL1IsogZ396o9L4vnqZnhuhNz2xHycYmUOx6XKzKE
	RU5qq9frcLgbWRmo6zzQHMddihkc/KScSL5fRG46mRSrZa+D6zaLCHntORZxjWtQgWUyU61LHRp
	Wlwge4dfe5IzBaZ+GALP/Blugh8q/gj9nQnocr5iU77DcM82U/TYsTIXkZaRigOH3iltj2wHqg1
	Rk46rQBsSnrwNVEZRbwLw57FwGq7DXVHAlXf5vyQJ5PV5hNl6Y7+t+8YF9/Ntium0gdC74Zil1G
	Yh+XKqkOSBf1dqGtZydTPpp4R0Fc1NPCXUOq9KDemsVr31GRtGHuvclRv8KhFO5wIG+OKngyCSZ
	ZfqsyHfKhlrNnYWw==
X-Received: by 2002:a05:620a:1707:b0:8f2:1ccf:46d3 with SMTP id af79cd13be357-8f7b5ba3b11mr259665485a.7.1777371361200;
        Tue, 28 Apr 2026 03:16:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1707:b0:8f2:1ccf:46d3 with SMTP id af79cd13be357-8f7b5ba3b11mr259661385a.7.1777371360659;
        Tue, 28 Apr 2026 03:16:00 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b68632fesm536532a12.28.2026.04.28.03.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 03:15:59 -0700 (PDT)
Message-ID: <0c6c9366-a190-4143-a0fb-2aff38ed8804@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 12:15:55 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] dt-bindings: media: qcom: Add CAMSS Offline
 Processing Engine (OPE)
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-10-f430e7485009@oss.qualcomm.com>
 <aead10a8-45be-4f7a-ac6c-35a99a716b3c@oss.qualcomm.com>
 <CAFEp6-38=hcUOvW1yd+hRZ2nHV8sLxiLeB18uu-au=LgA2bQTw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-38=hcUOvW1yd+hRZ2nHV8sLxiLeB18uu-au=LgA2bQTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BbFl3HgxB1xvKT11sX901OXBzKZ-fr87
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69f088e2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=V0AHvZjihEha2N7cGZoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: BbFl3HgxB1xvKT11sX901OXBzKZ-fr87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA5MSBTYWx0ZWRfX1wm5r4Iqnuqn
 MB3kgqR+09Qs3wtDGOMKvOutIAIkL3TBO1T1Mo24mrlxWdfI854+mSfWxssYOFd37jv/8Jtfi5t
 gULslr7H4H9XMGe6vNPzL24trfWy1nZp1wGhz1hQzfJwDhFNHkyF/REfAMj3DWxLWOkjJ3jBig+
 awhuYfFWkPyib5t1SSmXa04NYD8Bq+Bs5eHyyKZg37ANk4ro9/FLjKvy2VijPbrlB2fX3Yqhw9e
 BWBkZwnmI/57hT1+JDYPKBb5gNsMP7L2qpH5650igCWmf0QVAK86jwKhZoBtKnLa9mqxf7Xxnrp
 Q+PiScq/+83pS1UtsgSKUCfiA5sGDpSTxUM0rXT9oXaU8uHh5UCoixWQxWP3q+xbEusuyJ9/gCj
 JUrcfTDCO6CDdKQhh7tiwSmhti4uaeyOeCfNCW6xNabckfHWfzm17i2HVClIAaCYHdxAt1S1Anc
 wE8PHhY4hYHOKANI7Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280091

On 4/27/26 10:33 PM, Loic Poulain wrote:
> On Mon, Apr 27, 2026 at 4:22 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 4/27/26 2:43 PM, Loic Poulain wrote:
>>> Add Devicetree binding documentation for the Qualcomm Camera Subsystem
>>> Offline Processing Engine (OPE) found on platforms such as Agatti.
>>> The OPE is a memory-to-memory image processing block which operates
>>> on frames read from and written back to system memory.
>>>
>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +        clocks = <&gcc GCC_CAMSS_OPE_CLK>,
>>> +                 <&gcc GCC_CAMSS_OPE_AHB_CLK>,
>>> +                 <&gcc GCC_CAMSS_NRT_AXI_CLK>;
>>
>> Should the two AXI clocks be aggregated by camss-top instead?
>>
>> Otherwise we run the risk of the OPE driver setting a rate of A
>> and another sub-device setting a rate of B
> 
> On qcm2290, OPE appears to be the only consumer of the NRT AXI clock,
> while the capture path (VFE/TFE) relies on the RT AXI clock. That
> said, this may not always be the case and these clocks (AXI / NRT‑AXI
> / RT‑AXI) seem like they could reasonably be managed at the
> camss-bus/top level.
> 
> The open question is how the NRT AXI clock should be enabled when
> required? enabling them unconditionally (similar to other camss PM
> clocks), introducing a dedicated CAMSS top‑level interface for voting,
> or leveraging an existing framework to handle this?

So, interconnect, or some internal, smaller version of it?

Konrad
