Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0937475E
	for <linux-hardening@vger.kernel.org>; Thu, 25 Jun 2026 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373897; cv=none; b=Erd2CbtN6wAZMHsGxDzNX4jZU8oweriH5nZIJNmciRZY2ZTdaIXGQPFfxECL30b4MCxLOuYKXSErRF+Xx11kbz5KVUqrMn/8y6xTtPAobiGX48rSpDoXN6jannS09wjxq1IF8oM9xk9kf2MUrWQeMTR/LboOzArTcReIlCvbG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373897; c=relaxed/simple;
	bh=IhddJ8wJua/m+ug2p6DPU/19D/1A9Q5EUbXR5cH3xDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHVkvySZ/V1qWQOTYcYBi1vzra1H/2mx5QKIWCGVzY5brCdBKctpT6KomV1AB9QEtcw39d7uAnA7+IKBvlJxpCujVZHit+RYSgjTbVmld/5kUGXlxxr03r2OU95/u87wQTcxGdhtVGXEuaEkO+hYpniGcUarHuUpxYi8ZWFKVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A6UJJ4mc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NlgibNkU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A6UJJ4mc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NlgibNkU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P45v5T994173
	for <linux-hardening@vger.kernel.org>; Thu, 25 Jun 2026 07:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7LTkSUI+YJToHS8a4HwcpVIMbbMkUqrCKJ7kdKLzNKU=; b=A6UJJ4mcHbqUjDYf
	Eov29aBmQqnUI2JQSICLlh0i0+MV00o7JJvg9xvz5n1S6+aG7QBrZz41TdGOc/uF
	bJ4kdfCziNq1+LH5/CfpAihwd0FUY3CzWG3ECu76F5EckGc93d4Zn/uzRhvTE3Uj
	8w74YPmuvmcqRpXwzBjdSPkJ0KXQFVb0BN8azOgT9Fud6GRbLEjarsrS0esqTu3v
	qiY2Cmy862MhkpMmk+GkSzse58g+tIT4Qu4rt9PgOHHRyRCCLHRnlwQ5l90uRzGR
	5KM75Lw3bPNwe1Ki2vS3GvAu4iqTtWeKYmYI2EuHX3ixxnIS/u9EqNGdNOkWopr/
	AZwVLw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q0qva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 25 Jun 2026 07:51:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-923c6c59f63so315908085a.1
        for <linux-hardening@vger.kernel.org>; Thu, 25 Jun 2026 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782373894; x=1782978694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LTkSUI+YJToHS8a4HwcpVIMbbMkUqrCKJ7kdKLzNKU=;
        b=NlgibNkU9FgRQJ4VWU+9JgVnA9Rk4awtcAkI4MoV7JlEkgYvfGR09k3+ofTZGvXhbe
         iZYh+iTdHowXrnxZERMGILgiwaP23iG830iM/w/jvVJUrPzi2wC+yIqRjfkLGRM66tkZ
         vlIhytqyZjP+tkxCXZWSjg2qttNTOpMXfbfTHgVWTGTCpySZyvcN124Zx+vskG32HFiu
         c3k7BxsbXuO9aqy9vDV4RiPZpq6JT1tDGAn9sbEYS0B045DLUm4k06EtCGtYNlXumMIB
         WXj5H7zs1WkiFXksHhA6i3yTzIeD2A9iYyrS0tJRzBo3NoxpnIIXDr9VBhtHSPHk4fGQ
         m9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373894; x=1782978694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LTkSUI+YJToHS8a4HwcpVIMbbMkUqrCKJ7kdKLzNKU=;
        b=KSrfR8WgdTwMDqrRA7TIIRjqEZu9oV3qSiaWiXsK6s+H6JdBtsruX0Y2m2cGfJBWTN
         lIemZ/Xx7BrgGQubQGFgjKY1fFCuJvBiDNgN/OdgS5OyHMiJ0PB4vMf/joEllLyp2D/V
         wDWbYOYBIHFhyels0YDPt5wB55lpF3Pvkykw+InXoliHftIlBvq8YaaXIuu1utZdJU34
         x1sQO31qogLdaVboAPDdlRZ7E7+UQfezwn4AGhjsPdu+IW+XH07f5b2cEUOlxEv/7Bbp
         a+3LLwSUJp+gO4/I8znCBtL8fbIILXbIUH8zMZM+5a/E6H69F06OGogrhQ0L5uJ/SiEx
         hbMw==
X-Forwarded-Encrypted: i=1; AFNElJ/osppQLxFJB8uH8A85BiMMeGTFr4g9FqP5xvfHqyaiWwcGdAiDVl6p1TDJSwSl/bGkZWMB3h7sinpI6bvMM60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTe9TaqyE/g2c3+AyXJ0gv08Rz+lm4A/r6JvfOlficivGTW3q
	VtgVa65mXNh5Ug5brGHljUAlhA1r7iveRJumPXb3WyyDBWTeB6taE0u5+ofN7DzejOINLClSLY/
	/Dz2jc+hZVfJ3vTaM/R2Hlr7VAaTKEddRFKNZSN+UKE2pmIpx3OYC3oEvX3fAgkRF7qFYhp0=
X-Gm-Gg: AfdE7cl77sFjRAm3HK++pzOyj/HtZxCGXsLQ3wOoAeHfAip4xj5lnPCa7JvAa3thZ4y
	q8uXT+faXdpa4CoiUicc2s6q8fWzZzpsy6W/x3pRm653S0RKXNADaDQKZZr+zK6gY3cgrzk2whg
	cLoeXHAfbsTBepKuwDNztzPv0T6hvRwviirE56Cimb+LfNBnVtuhGwDEYPOoznSK0gj4S1GUFDr
	stbOzud3qUMaSUkvQHFi2AIOfWUd1MpRVvAbhe/x0mmlukkECwMuXcoZiecQ4DMLvofjkW6b4RS
	IuWrjwHEf97OE80vDZFnr0A1yfZ1Crznd2PBvKHgoRV+Dbet6kIKg/C+FyGu6Y5qwsnphCk0V9/
	R4uF1MUSMcrqEsUmbqJFQn1VnKOqwxeS5fYoX4lgOdmP19dr+cx+RywpI//OCNfezSZ2nJiu/jQ
	==
X-Received: by 2002:a05:620a:4106:b0:915:79c8:ec94 with SMTP id af79cd13be357-9293d8b33f1mr194382085a.39.1782373894608;
        Thu, 25 Jun 2026 00:51:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4106:b0:915:79c8:ec94 with SMTP id af79cd13be357-9293d8b33f1mr194378785a.39.1782373894204;
        Thu, 25 Jun 2026 00:51:34 -0700 (PDT)
Received: from [192.168.10.101] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01d9csm14999506f8f.12.2026.06.25.00.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 00:51:33 -0700 (PDT)
Message-ID: <af39bf37-4ab4-44d9-b91b-b8fa1784783a@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 09:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <20260610-ocelot-of-stimulating-excellence-bcb0fe@quoll>
 <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
 <c32e263c-ba4e-4899-a935-e129de0f1269@kernel.org>
 <61765401-3397-497d-a0ca-e9bf9d76cc6a@oss.qualcomm.com>
 <5b0f1f39-ddaa-4a2e-ab29-34aacc9ff672@kernel.org>
 <ae0ec05e-607b-4022-a006-2eb1a283144d@oss.qualcomm.com>
 <d9582027-8555-49e2-9a36-c3b952dc61d4@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <d9582027-8555-49e2-9a36-c3b952dc61d4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mHcaGXNPNIkW3cGcXqU5CzTky2xmMkMR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfX4D4D7zkY473w
 GOvgY0c5bYLRINpQ9nid/pdK3zEturHFbm3Eg31VNhyjmyAqeL116CeKF0K/0q31iQoUTNtSqIc
 NJUBxfe7ZvIgCW04FA83AxxE1PBxi7U=
X-Proofpoint-GUID: mHcaGXNPNIkW3cGcXqU5CzTky2xmMkMR
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3cde07 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=RTo7OxITtARzf4XpFQgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfXxyaGm+8s5Dk7
 5j8RKxo0cMFi/aYH4iiujTVO0GhoEBouT0fUfgh4d5m+WkfkDEER1YMK7mppAIf4OKVxnvzzbpx
 uRmT5xJYJufgX6ESmzd8tK//7DEcgjjXt7ch5jDLSn6fkt6hTYtQxuFnAYqgftTXtwSzZrv9VLA
 etrIiYnwF68ZTGtnA8PK+xUL6Gg5vyT0CYlkn24r/QByWvcJSs99n1fHAB/enAIEpMb2EJjeRe8
 AMklk9BmOUobLNDg5+6Tg6tSr3CkCgExHDun4yNNj/7rY6V1BXv711Imfubf7lJ7dTcpSHiibAI
 TauKISex2gRzeHEI/SvyE/eZducboNLERdEEc+NqqX55UbOUdzRGUDvK2h9AH5z7RKuI6dEi1AQ
 Zk2Bsp2X538gemoaxZRmNVrT+FDzcOdnEfu39tjBcKwQe8UQzdGMGh5fGJZFqmRCkPZsUm4iOyG
 axM29AjBxQVgP0NurQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250066



Le 25/06/2026 à 08:48, Krzysztof Kozlowski a écrit :
> On 24/06/2026 17:56, Daniel Lezcano wrote:
>> On 6/24/26 12:42, Krzysztof Kozlowski wrote:
>>
>> [ ... ]
>>
>>> Therefore I still do not see the need of tmd-names. You know the name of
>>> cooling device, because you have strict one-to-one mapping.
>>
>>
>> There is one remote proc with one or multiple cooling devices attached.
>>
>> We describe those in the remoteproc node with the tmd-names.
>>
>> Anyway, we should be able to list the tmd names in the driver itself if
>> we ensure a consistency with the index by defining them in a shared
>> header eg. include/dt-bindings/firmware/qcom,cdsp.h
>>
>> #define HAMOA_TMD_CDSP_SW 0
>> #define HAMOA_TMD_CDSP_HW 1
>> #define HAMOA_TMD_CP0UV_RESTRICTION_COLD 2
>>
>> In the driver:
>>
>> struct tmd_name {
>> 	const char *name;
>> 	int id;
>> 	bool disabled;
>> };
>>
>> static struct tmd_name tmd_names[] = {
>> 	{ .name = "cdsp_sw", HAMOA_TMD_CDSP_SW },
>> 	{ .name = "cdsp_hw", HAMOA_TMD_CDSP_HW, .disabled = true },
>> 	{ .name = "cpuv_restriction_cold", HAMOA_TMD_CP0UV_RESTRICTION_COLD,
>> .disabled = true },
>> };
>>
>> ...
>> 	for (int i = 0; i < ARRAY_SIZE(tmd_names); i++) {
>>
>> 		if (tmd_names[i].disabled)
>> 			continue;
>> 		devm_cooling_of_device_register(rprocdev,
>> 			tmd_names[i].name, tmd_names[i].id, ...);
>> 	}
>>
>>
>> In the device tree:
>>
>> 	cooling-maps = <&rproc HAMOA_TMD_CDSP_SW min max>;
>>
>> I think that is somehow what Konrad and Dmitry were suggesting
>>
>> Does it sound better ?
> 
> Yes and I am surprised that it came now. So you had TMD index available
> thus the ID was defined. If device has unique and fixed ID, you should
> not have any more properties defining it, because that ID is enough. Any
> names could be only for users, e.g. label, but that is not the case here.
Yes indeed, having the constraint of cooling index and tmd(name, id) for 
the connection between the cooling device and the thermal zone was a bit 
confusing in our discussion.

Thanks for the review

