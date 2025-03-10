Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F1221D9B
	for <linux-hardening@vger.kernel.org>; Mon, 10 Mar 2025 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649871; cv=none; b=Z8L8p4HR6OF5T+le32u5YAhUgmiyLYmr99W5MdFl3unG6MoL+G8JaDoqnNevzuIF2Exvtm6xoeLZopQ6VjDRIiihopMrP7nCXRsLRIA5UWQ+3os70EG/ht+8g3irT2LzMKaXYHWsxwky1ZB4MUi3175yoEC2uX0xmKuXDAYwgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649871; c=relaxed/simple;
	bh=+J/gIo4jHxazEkQlxKxKqAY1qd9upi8y4fJP2X2CZWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLMwy1rNGiV1ENA8DQ97QoVEG40dOjhnma6SHjEJQwelsODy6xagBTEXzYTLzdl+NLSWLopKUxzfGb+tlSeCZ3aBlwGICDg5g/V13GhMeaIRNw1nCPc5UeWM4Qp/IFJWSZvLnI9q+ub7II7i6jf8O9Jp78LZLoHYEALBKXLuiqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDYofdhW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDYofdhW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKXGT4025844
	for <linux-hardening@vger.kernel.org>; Mon, 10 Mar 2025 23:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B8TFjGbBf7rY2t4VlMRWb4Z8bam2nqJEippM+OCcgS8=; b=dDYofdhWdXPuo8Gk
	X8eUaoBELPf5r2lDlX2BT9sMdcIDGSW5uKgszDKROEAaiRN32B5gNT5r4XoSNwu0
	CiAXxrBVUk+OwA+0x0mvqy22He+HP+pilje1+focREWPQCX7HoSvVhal/Cq0SGno
	BkPzQKpnwUFPox+PD9jiuJKqfklESge/hfrewZ499QFGDPMzbcBjNbxtCJpkTzSG
	xau+/sWaYf6NZqx0OWLR+5co1SNQQQs2Lo32gAlrpfs3D0ipl6DW7+A8ZoHMEhLY
	JWBMx0XndFszNzskJuP18uir5cSqTEIwgNvr/onXRlcuwy+inZX13S5PzPA29RLY
	rWu26w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ex6xff5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 10 Mar 2025 23:37:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7be6f20f0a4so136966985a.0
        for <linux-hardening@vger.kernel.org>; Mon, 10 Mar 2025 16:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741649867; x=1742254667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8TFjGbBf7rY2t4VlMRWb4Z8bam2nqJEippM+OCcgS8=;
        b=FQzIbDNg9vU1NwMP8tYbuB3R5oD93kPsp5eVneyIwMteeI3YGCSkrj8j0pBIIqytvY
         p4mGd2ig6M/EC2BVGTldARcTsAocHrB3JFGxOGEUovllFtutYStyyGDehxvxZWg8y3sN
         XhgQSfmATfRMSk5Bom6zG2mLQ+DUGl/qxM8eFAyCksXMnKJPNcFebP+Qv5ZOr9JqU3Fv
         WmU1jEybAD8vDj43j7z0fAb1QG4dNjfMw9p3pz3dR2CvoXEUXJwSx3I8/1Jxm9njb5fo
         6y/swerwthroukBGofO90VDcHsogNpP0Mew9Ey8Ii4EQ7oyh5h64IAESWclVle7/NCOx
         XF1g==
X-Forwarded-Encrypted: i=1; AJvYcCW+DZglcfzjJJatIZ93Q2ykxhLFhEb4hV4KLTg+45G7X27mYTac/b7a2A8UVhVbIim4Zn4S5VKvNYMK1V1qJKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPWircCvR8gyYnxRZLX+3ks5sdHe23LsUn38fvpWRvwhyuVWNv
	uTY82BskEu60siVzehX/KqbxPDtYrr1cyc+ilp+M6pqjEZMJOZkJjeIfHZI2ZvqrDWKq7zr1wrr
	3Wi21B2bRU+oLFrimVEX8wFbNgrkW+eG0RXZYy43137B3xc5cQYSMNtWbEZcSFS+xTIs=
X-Gm-Gg: ASbGncvqf+qTcNjtjXe21A31oz1J28FKyJJNH+J9lZkBrrvhebvm/zzwe7iptUfX5DZ
	APKjtQNv0yKJxUMws5jxTpd1BO3NJIgaoKBuTgUZPEShiCblgqjFTvGeilj+DECikdUWNuiRYaf
	m31hZioMPgVjzoDzs7eYqN7w/wIc0WuApimQjkYhtwUZROM44u6EiHvE7rzFE5IvHC64NYIkL5u
	L5fE8izlAnL05I+hGDuTc575HgSPlt3u/P6gTyE3P07GowRurEWQ1+3CPtzWF9Z8rWldEuC0CDl
	PDb2WETJ0Hv1ljlKn9pzhdJ8QEjZW7p1FOB8gikC9n5m5p21LAWHEp2ozl7OBhU+7EF5LQ==
X-Received: by 2002:a05:620a:2603:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7c53e1d8eacmr535687485a.11.1741649867265;
        Mon, 10 Mar 2025 16:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Mp5wCFYiwFx0JJwA59DroSlD0bMK7BsJYztTlXkZgV5YDKGVGzmedYfg/iXl/C3zcTEbzg==
X-Received: by 2002:a05:620a:2603:b0:7c3:bae4:2339 with SMTP id af79cd13be357-7c53e1d8eacmr535685185a.11.1741649866890;
        Mon, 10 Mar 2025 16:37:46 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a194sm7397206a12.59.2025.03.10.16.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 16:37:45 -0700 (PDT)
Message-ID: <455b685e-0ccc-4c57-a60f-39ff9cd280ca@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 00:37:44 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm6125: Initial support for
 xiaomi-ginkgo
To: Gabriel Gonzales <semfault@disroot.org>, konrad.dybcio@oss.qualcomm.com
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        gpiccoli@igalia.com, kees@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, tony.luck@intel.com
References: <0bcdb8f9-9a3b-4d6b-bf7e-55a22ffc5df9@oss.qualcomm.com>
 <69f26012-e71b-438f-ac58-e0a3faaf4d43@disroot.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <69f26012-e71b-438f-ac58-e0a3faaf4d43@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G8bmE8k5 c=1 sm=1 tr=0 ts=67cf77cc cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=FfWvQauag8hAH5SirX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 21w7gAOAUV-2sgMG6cKIYZc4CrEL7jKZ
X-Proofpoint-ORIG-GUID: 21w7gAOAUV-2sgMG6cKIYZc4CrEL7jKZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=962 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100179

On 3/11/25 12:28 AM, Gabriel Gonzales wrote:
> On 3/8/25 23:11, Konrad Dybcio wrote:
> 
>> > +&hsusb_phy1 {
>> > +    vdd-supply = <&vreg_l7a>;
>> > +    vdda-pll-supply = <&vreg_l10a>;
>> > +    vdda-phy-dpdm-supply = <&vreg_l15a>;
>>> +    status = "okay";
>> Please add a before 'status', file-wide
> 
> 'a-status'?

A newline.. the brain didn't synchronize with the hands

> 
> [...]
> 
>> > +&tlmm {
>> > +    gpio-reserved-ranges = <22 2>, <28 6>;
> 
>> Would you happen to know what's on the other end of these?
> 
> Unfortunately, no.

Usually it's some secure i2c connection and pins for the SPI host
that the fingerprint reader sits on

Konrad
