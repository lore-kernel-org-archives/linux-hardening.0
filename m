Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B4F1B6D08
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244983; cv=none; b=LtfiAhKyv8EpNnw3dvmrAY27SzXpwzziUT4RZNnyA8qWRkATwH0QK5TR8Op2Uwq8ryuxrAItfAS66ILZJdt4iQaYGsP7aq+CLRhPgVZeDIsyGXLwuJi2SPGgTyu7MOvD+2PWjm7AZBktgwzbjx1Zxftcci8t3FTcbYcGXRM4TS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244983; c=relaxed/simple;
	bh=m0WVLtEMOLSm9zDk1d3O6jTHTPnftcVbrMs10BE0Kzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoVr/+ppLqpCbmdmJthhyMsj3p2wzr04XXx5b6ecDm46SEOmITHFAiUO5eKlRQyCpzUYUfL2XzWRXKq57r4Ea5eWQMhGmgS8Gv8T4AF9cY0BbF0KzAMStTaXwhc89WKRxYXGwjFl/5weVRyolz6VsW/2z7URExr/L3E/dQS7868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GW7uBFTf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GW7uBFTf"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFqEsc031417
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 21:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ovwcz/UMx+Ei1EUDipzRJAkdj5/vHnIo3oFAfjDRoTY=; b=GW7uBFTfEjLK1VD+
	jvcelJdkc9D6ELm3oQep1HEk63GXjAQGze8wezUoodAtkr4xi+hm1vjmixN0eaoo
	ZMdPJozGh+tGniRlZKtVl1AlZMYsRqESV39zfdp1M7UVc6BAF/suWs0gP1ub7YkE
	np1pOHkTc03QgmcyS7QXDEDKdem4JpdwM2KBuaXvGuMZ2qw5gZWnIjcAIGJKrLNt
	HcWp8bTgc+WvN+ghBCrIIMgeZuUh+pgZkyxL/b9Ta1rHtyYYrb4IqkyvIG3grCN2
	HnEpw+GWEEP+WBzz3K4tDfZmphSbo8b4397190wUll7OR044RLWLhULiGcQ1ItOT
	koFGAA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfjewu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 21:49:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b49ddcdd5e9so4159549a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 14:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756244979; x=1756849779;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovwcz/UMx+Ei1EUDipzRJAkdj5/vHnIo3oFAfjDRoTY=;
        b=PwApAOnwZCEtw6IovN8ZFH8aRUaoG1gQSbUn+tX4Q3QoxWfqROrLcaFB5avrScnPei
         KjucT4rw5SLyR6lthiyjxDFFxkrqF5C1v9VVzw7fLMHJ8jP2Eehyg1WK1CrJCP57DEry
         pLCqyxD18QBhO491sYlVV6yWB0XyTTbW01b7wJpK61hy7/+176axjmhKks+RMj1O3upp
         ObmOBUz+Z9iMpN/YrP+57rfg/p0/PLip2uDMGN+/odCBuMcwOutjyCujo9uuVcy65lR0
         KaWFapsqTfmxCmRlo1zUQr2tknnN2O4pDdnDcmRW2eQ6HbPE9GaBiNt1yTRsgXmAqQEp
         LJpg==
X-Forwarded-Encrypted: i=1; AJvYcCWxVzlagDq7/TadsPNTe/Bw5AWOH4cikmoQroBNtys6g7E44gXo9qUpmjOS6ySNHoscxVLw86C8163IJQc+nvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/BtMY7tc41bDuVsUrTGM5SwXCLuRGqzmw7XI/W5VD/laa0ll
	m4s7+xM7eO5HeHYTJSfA4zLt0uN27cIyP8meDBEI0zl9rsZBkdg3Wnxn5zpEzaznpCmKtuu3dbf
	xc80Jpn/WSe6QDLkku+E7ORI98vrqQ31veThqelDw0F2SNjiM/o9RVGTwju2Z5AH5ZKE8TPk=
X-Gm-Gg: ASbGncuQr3ZG1xt5J2xFxq7XY2HgJBW2p2jYoYMGOYmLTleyLl0GiZ+tsHY+HQgqUo0
	bXElwbt/vNB/tnTqmmXHomoGXui3yLF7RfZF9S4u0DTIrklJKrXdAjOXoLiwn656KhmN1jKkACU
	5R58m1zwslC4st+6Zbr3us2upXHWgZrDorvrdnx91hQXN/BBst4voMU3FVPBVeNF3Ii1gHjW/x5
	grmeKJGNh5XxDCg8rDvpK51/WOLElJ1HNgKlUl4siLIFlAdC7+wrZDJcG1vYw425p+mgw46K7fS
	QRR2dTGZptZ13y9JHbkz///bjgOxuhSRYgaAaTn0bi8V4HZVPXUDJI7Ni4VUbE3sAjIoWcW5G6Z
	FhNN4JmJPjgzWxUr6rHoes73xuN5gktmz
X-Received: by 2002:a05:6a20:3947:b0:23d:5691:df51 with SMTP id adf61e73a8af0-24340b01b9emr23163092637.1.1756244979115;
        Tue, 26 Aug 2025 14:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvW96AUyv4NFuLjcj/uDmOR3GBBgYMnkq5H/IYhcNWvdPPtmf37a1KlGOYrRmV7mrjTboe3Q==
X-Received: by 2002:a05:6a20:3947:b0:23d:5691:df51 with SMTP id adf61e73a8af0-24340b01b9emr23163064637.1.1756244978686;
        Tue, 26 Aug 2025 14:49:38 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c1b2f5a3csm5860905a12.4.2025.08.26.14.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 14:49:38 -0700 (PDT)
Message-ID: <e43ffda6-4d25-4874-99b0-6a65fea4a261@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 14:49:36 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI
To: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@outflux.net>, Sami Tolvanen <samitolvanen@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland
 <mark.rutland@arm.com>,
        Puranjay Mohan <puranjay@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20250825141316.work.967-kees@kernel.org>
 <20250825142603.1907143-5-kees@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250825142603.1907143-5-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX6B8vhvM4pcwK
 5xwDOQ3KD1IXctvHWGyEBgDQ7Pueoz5BIy/tPGdHNO/MgougEBru26I7jf4hK77x8RGFZ/4S5vL
 l2gUbZ6RqDSb/wPJJyGkYStkxDEeuPMKi8kmFSbkeMDONQlioh8EyXMPh4oVng08b2+l77rYNUZ
 Lpbdcg4YMYhBj/Y5QsnpDUv0hRtNf3kZh3s9pBqjycudGNoohnenRmQjWhvO1bzyMOXr3BT22Ie
 920kX6NrznqkFJvYteiv+VgAi71OFTqCQi9jTRx5OcRGlqN5zC1LdOiRCRKlB6az+xhBMq8GCHI
 xVDc3DnB0gK2UCdAA+v31ZnqfdpMzK81t5tAoWft8skj4okUvwkGZgZca6dhA1/EAA8snTs1G5A
 ROyTYXwl
X-Proofpoint-GUID: E68LPvrXW1tZ6u_NgtchpyqjO7uMPdub
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68ae2bf4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=ZGSs6mt8D-bwwmi9yLIA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: E68LPvrXW1tZ6u_NgtchpyqjO7uMPdub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On 8/25/2025 7:25 AM, Kees Cook wrote:
...
> -config ARCH_SUPPORTS_CFI_CLANG
> +config ARCH_SUPPORTS_CFI
>  	bool
>  	help
>  	  An architecture should select this option if it can support Clang's

nit: Do you want to replace the mention of Clang in the help text?


