Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA3834A3BC
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255892; cv=none; b=KDWs5CFzRmyBUmU1ZQSIEguSp8LSeVzfwB5dHycka0jHiOoX2H/QZtqduw+k54RfMXzklIIdJ8xp7ZRbynatZdD04FGvFGTVif7E1QkYtJnweu2GI2uUm6KKJR5Hs0v+ptc17REMNgq4+XIcGoFjX1R39BFzSz4Teg9kZ9OD8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255892; c=relaxed/simple;
	bh=Ij35304MyVdMGpBR9HlVwgyCpE8KQSt8d3JxqXR3QrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig3c0jXmgl7yYHY2zfeC/wXDKQruR2F3GMSoNiuAS/HN9iHgziVlr4ZhIhSu+KHdKbd5sx8MAd9Djw+4y298/scubS6XuQh/PblIhWmEeMDKLvMkd5KXjYD2XQ8d0pWXLLGKWocUG2qac65BOHGWOr5Oi9wj6dEOFLdpJIVl6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T5/Pts4X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kwVjLOCl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T5/Pts4X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kwVjLOCl"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CJFpGA2028775
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 22:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fhEhZwjw8HgyTavKW4D9RGlwsOdPgS5h4taGGLgVlvc=; b=T5/Pts4XE6rWmKAx
	R5hKrYgRuXwJKvNQ7/F8Qv/meNZkp8t0lQ9EwDMeiJLBmx72R3dDbLVgSB5zIjnS
	0EWjJ9WBlP6kNdcLdGjBDAYn0YUPS1bOysMakSnV7F+hGSz1TZv+Cg014gd6MCGn
	VPoTesCNO9ECXmuvxRW535qKYp1r5+dfO/TK3UfHNpbph2G6M4PUiREWsN92r+J9
	jZQ+YFjslOXkvXS3GPoNnySlOs93ZGurclPSW1cT3B6uj57xZup3e6yJ1pmVGFn6
	ywGA2rKri0Tzk7uzHifdI4n9U+8EDkNKHeWpJ7rlzko4f8IRan5CZbJhIT25w0Wr
	l1S8RQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6y8regm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 22:11:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2e41884a0so1529468785a.1
        for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 14:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768255890; x=1768860690; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fhEhZwjw8HgyTavKW4D9RGlwsOdPgS5h4taGGLgVlvc=;
        b=kwVjLOClcceSzxEXZ3l/S2Xjd4vIc7iuL/sLLbZcckiJOgL70YrxeCcA8o1ej2JisR
         fVW0TLusUPqMeHxGqM9IhMlkZy7aKzGVr5JKUZMuz2B6fh8W/3wlSHcWbNUrZ9gKH5LI
         lPyQizsHhtmFVbTZIqv4O3MS5hIaUXhu9DUfKWZj2g8z6cr/Myf4nKGGSsZ++eEEAjiy
         Potx5hxgQf+oFTC6lV13LnEcd21AYFDUY0LScgibu49zV4lqTV4kcfJRRyzGOk32jtLg
         xmdj7oOXpuoYl5Saygv7JPoCQmNMhepi7gsujgcK4gDFLT4gErmj10Po0our5MVVwbjz
         WKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768255890; x=1768860690;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhEhZwjw8HgyTavKW4D9RGlwsOdPgS5h4taGGLgVlvc=;
        b=VU+URI5wLCYuDm44TTPq5QEYbW2OHfVTF8C0YlRbs/51fbYQlaHr+ZJPiey6GknyDI
         kI7xK0I95NQPCH0mz2h7UGg9+AysMb6Al9wZkdZfUVPMxQwb9/+cnYZR5QZzx7MO2qzU
         hDn2g71O6eFndmCuoF3SJgl2mqCY0DyZDy3WAKkkmSxA/w32pUJv0JRFHz20mOIzMg+3
         IfCklfZCmUEF+JVP9f6Kt4pOTrjo7//r796Y7Fh7E2I7wMNHT4ybyGFY+q5AgsIn+Ooa
         I3ZyBplaUZBZu8JH/f/nEruva9n56Y3bc/G6gNGXXfQQpXZq0tJFBO8JUNVtWTynVObP
         wIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3A0e6v/oNgTlJaLVHmV1nv+GqidAIFc6i18tMTrVoIOk+8/ORMoGd+6UZ2WqwylzfssXa7HN01TkzFxkECyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqGybN8ncWTLczA0DNg0+Ke1QUeC+5BlZwp7tj2eziUKQbCXQ3
	nxZm7y+bxZWWe9XbA0FTSrg+nj0Efr7nPid3f99NUAm7FukUqioP4JmLoyIUwjCR5gC6/NXNPFv
	7sBnP/0HZqAoDhe+OKpIKWrCxa+EuQbd0HZmBv2bOQeejpe02axZes/JGqIjTYpRH8RVbaSs=
X-Gm-Gg: AY/fxX4smNinALpiifSZDokpql8/4oUMI8EsjD83vcwdV9Ghu3LX+I+id5gRBLZTCQH
	vTdYDHPEU/IE7XRkmKN5tgICvUmL3Z1PbYeSrwjWQJZDBikWaA1/9VU4pVB1Lhcv77ZufRRje+J
	QMa9mTPqeJks8t/yHH7a16a7Jw/i4QZzkEk/GKYxDa+7rxJY6fRtkJ0vkoXZupNbNm9MoXt626T
	U89B8qTmZQdNAByNY3rj3hzagfY6a8fGHzmQMV4TAPAH6/z/lNYcnE1Sj/U4TzzfBnT7d9ie3sW
	Cru7amlHo08QoPhn4yQQKb3XftNlaTXKyLpPtS7gj41Mdrcx5PMiy9t3i+ICAZXosH1diQXUcDW
	BveEVGHy7tZmoImUS3z0fPgQZpcH1eEQl3vz38G3NrpNWB1cJbKbDcXpP5wMbS4YFN/X6YGXk2J
	yQLaoD8Jw1AUxM8kqnEKbyXfk=
X-Received: by 2002:a05:620a:1a97:b0:8c0:cd96:9bd9 with SMTP id af79cd13be357-8c38942954cmr2803827485a.90.1768255889734;
        Mon, 12 Jan 2026 14:11:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd3WmM8Er6jZlz4GY+Gci8L3m6OdKJ6zduDCwmHM4ZmhRoP3rIVclFhmckVLuP7QTQ+XGYYg==
X-Received: by 2002:a05:620a:1a97:b0:8c0:cd96:9bd9 with SMTP id af79cd13be357-8c38942954cmr2803825085a.90.1768255889303;
        Mon, 12 Jan 2026 14:11:29 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b7868955fsm3403076e87.2.2026.01.12.14.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:11:27 -0800 (PST)
Date: Tue, 13 Jan 2026 00:11:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gabriel Gonzales <semfault@disroot.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Biswapriyo Nath <nathbappai@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Fix msm-id
 and remove board-id
Message-ID: <6mxiysnjmrije7hz3opgaw3f5kn6p4glgoivxvnizrkjtjiywe@5qgj4jxfxa2m>
References: <20260112-xiaomi-willow-v1-0-8e4476897638@mainlining.org>
 <20260112-xiaomi-willow-v1-1-8e4476897638@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112-xiaomi-willow-v1-1-8e4476897638@mainlining.org>
X-Proofpoint-GUID: CCOb_MuGXKtEqlO30WKPEnGLxo_pMkvq
X-Authority-Analysis: v=2.4 cv=dK6rWeZb c=1 sm=1 tr=0 ts=69657192 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=4Ix3DnIw-zF4zot3V68A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: CCOb_MuGXKtEqlO30WKPEnGLxo_pMkvq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDE4MyBTYWx0ZWRfX4bbK05W00XYA
 HxLujs/ibmUYE6qy50xlyCCdBPLQyMEJ9Hm6JTQj8F9TMj3l2yk6NB2utuDuJCNB3iiVgQNxVrI
 6D0CafGkMmEDOStRq7mdcpQ+LZdhvSyBIU0qs/3aX5x7rqrzpd5rPe2l3PFULXOX3UpRxIyeCnk
 PyrBIFjcWQqy4Xb/eunk2r//nfa++iLKXvjUQQD/IsLIbCVxmhi0nb3emM2a72PiTmSmLvHDRxu
 Py3rEUsiCUIMCopAYoDgbItOC45MtriOUpqodI3XfxsyGEsopYdlQILH8jr8FJLEprpot3qTG3g
 Fn346bo8mo8FHcFz8qUWmr5CfFTo1s4ursSjr8c2PHk93adYLk3U2vDbF+XGptW0kUl+XnBP1QX
 Re4Z3oNAQUkH09fEbm/uUmH9+h6AD4qVVOozpNkpDfGNjWJ3GkbOxynvLPqQR3ySFdiEYvMZw0O
 6YH/eF0N47/fcXN/qdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120183

On Mon, Jan 12, 2026 at 09:13:24PM +0100, Barnabás Czémán wrote:
> Correct msm-id what should contain the version 0x10000 and remove
> board-id it is not necessary for the bootloader.
> 
> Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
