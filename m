Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4A2D3727
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121647; cv=none; b=EyqE2xz4npiAYTbqU+jp2e1In0ZiIcvKvd/08dnjxoxYePjre51w8kKlpYDb0Xl6RNfRFsoO0yB38WwY7EZbzn5W9DYoaOvpY00vheWewAqy37BLjKSboVNfmjhqe5KthTGEA0YC4SAoICCeA1tf017dZO0WaPZAQ7TJfmVEcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121647; c=relaxed/simple;
	bh=3WEil0ehY5vXWc5kCGbGh1iNwldSAw0zKkcaT1ugWPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf9/iRCgW6hkNdeQlW1SaqgcmTXbjAca3Vr5ofQd0RoQyCjllPEKkFGGc0lK6Ec4JllVrfKBxmFLCSsE0/hespMgtWj0oFjXglPGdS4ovG0dNWWRRnHQDk03CN+OyRdplfanmAEXgfKDZw8LPd0+8swIeNDyawJ9t5yfS24HMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LCJShcCJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LCJShcCJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLo5J020907
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 21:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PoxP7tG7pCID580yMt9K2LXcQBndbjiv/lE6hcV18C4=; b=LCJShcCJqrQ7J/v4
	GUKejkcaQxV4s9YPZgV8B6+bo/RivOwQyJyJEdjsoQF0qnCkgT7sy1D6zqHnV1vO
	s48+BESFy59JftqMeDl8n2SDCymjYh5aSnCrr1TbCWVG7Kb8IsVjxSZcByDlSHAN
	8IrmNbu000mwJy7GjCPp4kET5WaJXICZmjJntGnTE0eEMzog/jpTZ5T/46QLADsE
	i+pm0N50cbRTQcgWZjzDqVKjtbuQQq4wnqRI9wswOhQOehQ0zOZXm+n7HzJlHfhZ
	1MBWBsL0LP9EGj1Y6HMPq1rsJoFE8RUKzy8jCWnsHUV/YTgwCMYi2dS0hOqO/jCB
	TFDVQQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9swk9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 21:47:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471737c5efso135053a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 14:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121644; x=1755726444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoxP7tG7pCID580yMt9K2LXcQBndbjiv/lE6hcV18C4=;
        b=Vq4IQeChwCr5HYOrBx6OKGL9IeFUJBa47w72PEvVoHJrk+5tcBJx7VMiDQrtaoEnFt
         NW6/Uy371XCuy1Gevd9A9y13NChlyhTXc9XKwhwPgR/RVHP7OC1L1LZ4EZGUEvtumaWS
         tVeur3/jeVFNETv6pLYwHyo8M0khdNcalAirYBMs3j46bx3S3hYSw/GJXpkQtnvq6MxH
         iCasMlYa2aI4pVma6RBANGgQIcW7omPFjSb14iyleg/P7qG/f/0Djh+UbEDGhLX11Flj
         /H5yiNg07zzUaRD45xqLlaO8ih5oXLr4dCmzzOENqOb6ZtdWTcJJcvXRxObJ22cfjEK3
         nqiw==
X-Forwarded-Encrypted: i=1; AJvYcCU0zxLOL5jvTvmmrvmkWk7gwbpHQF4liEYIyRLVXwiIvKpjAdpXFkRKVr6JZwnJwIq8E+iBt34sdKlbDWreWmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0TjeZ1gYg9BkO20IDBiLyMlIEL4Z370w1mcQYDv930iGkeVs
	ombC8QRBKCwHIo5lS9QBJyrpl5crfqeum61szgNo/1s9VbcKyp+ptk10Uuy9bdcKXI7dAVDf8Ue
	0VLAUiHWEfM78+tbw27ixnmow48Vom7hCIrjfczPs9eVKMfxxz06T/3S1pOr2zdJXbTNXyg==
X-Gm-Gg: ASbGncve9MnoCalmq7/poaVqmCqOhnpF7xej5lEuE+wee4U8ogb88IoOusL8BD1x3Qc
	ww5hV+4FQKys0T3YIudir3gc+RhSUUZt3MewBpP5G8y9YOsmDKLtfg+mLdMuEZT6cxsZbnC9GzQ
	VaqWYZuV7QcDGgCd4nzGdLCJQvw6zn1lY2kbQx1gc662PQ+9UB+kkaKhll7b3+sFdTu9IniT14I
	+5i3xTzZqd4hQREXZzSTRwoCwix6+Vy3HT6Hbye1+FexOre7HUKKYA8ffPe3NM7bcQySWj7w4b2
	CeZz5g1I4gYVHrrWxHs4mqUPJpJoDzi+ZIuvwQ+zD5Hfr1R3AOJ5ZpM03D69w7uxK/1eaLUvxuJ
	7lnGn2YKEd78oSxJuMQ/31PaMT7vLzwV5+qAkBw==
X-Received: by 2002:a17:902:d482:b0:242:9bc4:f1c8 with SMTP id d9443c01a7336-244586e1b69mr7940575ad.55.1755121644280;
        Wed, 13 Aug 2025 14:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgjyhLi16jIYpZ8EHZqnYQaA0dKD8mdlmwaED7WOs0d7tmfiyJiuh/7q2M1HKFCS2ese9Jpw==
X-Received: by 2002:a17:902:d482:b0:242:9bc4:f1c8 with SMTP id d9443c01a7336-244586e1b69mr7940215ad.55.1755121643848;
        Wed, 13 Aug 2025 14:47:23 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323257aa89esm1010760a91.23.2025.08.13.14.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:47:23 -0700 (PDT)
Message-ID: <0af9ac59-9b91-4a0b-92fb-b44e0e008431@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 07:47:14 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
 <f10f1602-972a-491f-9c11-95e5e7bd80f8@oss.qualcomm.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <f10f1602-972a-491f-9c11-95e5e7bd80f8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689d07ed cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=dTt1GwfqUVNo7j6m3doA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SQfSUjwiJTETf5NLB8e0MoQ9yh0IoFly
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX4/K1npo8lnoP
 OQnqR7g+e4XOokYabj5+WzGRKcl0Dndqy9Y4W+Ce/w2DJclOG8/G7CLajBClcUcdpSC/KN80UAW
 T1UCrY4xB4i0yg0ZQPvO2j9g1T59oj9fiKMxsDuMraIgyxUSzUKsmRNi16gdEuX4wvOateQ8DuA
 FcuuFoxzMcZHjT9bYXqqO4G7xtRadkmOzUpm6RltO41m6H+vP/JX7663Ib1u0mumrOmIPzU7s0H
 gOAi/x2IOAId5wAfZXDUK7QXXMKDKbOS/R2C9sd7D+Y/nf7SdPBIgaxmsKkPsy8S8yTI8YtbmpS
 4YKRb+x7622LZGkr6zNOEeq/QBddnuAPwuIcBMI+Iaa7ZNXE8njlIKhMXlgZKUGOtooHekEVaEy
 ZbLfryFS
X-Proofpoint-GUID: SQfSUjwiJTETf5NLB8e0MoQ9yh0IoFly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015



On 8/13/2025 8:06 PM, Konrad Dybcio wrote:
> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>> Anyone with access to contiguous physical memory should be able to
>> share memory with QTEE using shm_bridge.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
> 
> Hm, I thought the idea for the tzmem allocator was to abstract
> these operations to prevent users from shooting themselves in
> the foot, and this seems to be circumventing that..
> 

Yes and no. The TEE subsystem has its own memory management code, and
the qcomtee backed driver will utilize it. In other words, qcomtee will
manage its own memory, and tzmem will only be used for drivers that
communicate with QTEE without involving the TEE subsystem.

This aligns with future extensions for FFA memory sharing.

Regards,
Amir

> Konrad

