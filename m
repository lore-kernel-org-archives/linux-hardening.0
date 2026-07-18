Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BAC12F585
	for <linux-hardening@vger.kernel.org>; Sat, 18 Jul 2026 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784418408; cv=none; b=F7JKXt9jJExVNe9K3HwYb8ivZbQwrrg0UO5aZ2bFre0quFNZGqx+jO4E/bMd8jWLx5/5a/FebuMev0YWhFhv0Z3C6GKBlG/1wH/Ygo2CRxBK/GXmGTFWYk3I6m48yUCJkebVwEmsWDx9oq1OT5q0vHvEParPQC5G05jNL8xsqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784418408; c=relaxed/simple;
	bh=OsIvBovZjcTK6vIoP9bjnaTXOZVjp09XO7gy2+wD8rs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acyK4zPgsC5Js5qqrv5jKH8x34C3NNIZsj//DbnvoV83OasTIXz7NhD3QdDmsu0U+p1BOcCYoj+tJ9zmVEs42sufsiKO0thhEyDk/Piyv4Mk/Za4dDhxhy8wUXUvyGbn1kL/ECVf9qoGlzrIDhi/8nH25d4zici0lscGtvgNGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZ2ndLpo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LH10/UOb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZ2ndLpo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LH10/UOb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN24SL1812004
	for <linux-hardening@vger.kernel.org>; Sat, 18 Jul 2026 23:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ITSdZDkV9Cn1Z6JQ1FPbQ/2s0KFaMPyxzL3H0Lmz/I=; b=DZ2ndLpofXSIvdFb
	PEZEv5tqLA7PUJs/JNndOi741W5gy0tSU59WDGSww01VkGtve2tpi7wuvsPuj5eI
	cgOi7Hb7Rc+UOAZ5XYMLKCNUjwyaIiUF4coYR32GOd1fBwYfMl78ZNUc18Xyw9IK
	HYMAcYPAeOZmxtaWddzSo2oc4s0H6Byvo4FNxXHTsL96evztcjhNegyxCyIjP0Sv
	07Jjp8KnGcREPKXf2J30aqsPwSZFOlbSkDbrka6KruIfVEJZlAd9+Fv1dKhGFD8y
	GvnFvP7s+4t6L5WF/DSj0u0aYhfqQ8B0eoCj//siJGO4VBVaV6xXWtpbyjSsfCdT
	CfF14g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chhrha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 18 Jul 2026 23:46:45 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso2962820b3a.1
        for <linux-hardening@vger.kernel.org>; Sat, 18 Jul 2026 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784418404; x=1785023204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ITSdZDkV9Cn1Z6JQ1FPbQ/2s0KFaMPyxzL3H0Lmz/I=;
        b=LH10/UObHT7emA2NnpX3x+1By5F3SE7Jhl0RJkNqgruzEpx3K4F80p/Bq+WeBWr5Fk
         k6gw1XeNj9KneSrc32u+HGACGzulLhHeZeih4A0yTw9uVVZy//31ff6iXNEMTDpo+0Tl
         psAGLURf4MV4s2Ztq8D5iK9HUX5FTQjsTuBQqXhxZddu+UZrZI9pF/FdT8kSC8LEX+7X
         b4WlX9BolEROVG5UOkfXklpiw1Tp74x+O8LsIQD7g+3mXSwE9B9qGODSDUknPyOCy6j6
         tq9RuUfZvwa2wldl40q+mgV/DgBbr9nwfGsiKmENi1JwmoJhBTaytL5SSz3+W1E10w4P
         eLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784418404; x=1785023204;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ITSdZDkV9Cn1Z6JQ1FPbQ/2s0KFaMPyxzL3H0Lmz/I=;
        b=Bm83pQoSQ9hk92yy8Fn7kqKXH0oM0lyHbZx5mS78Qc7pWGqc5vIvDA1p0JYbtHRA3V
         fZXnAVTkNG/IkZNG4650hg5YuPKl5krHiDX9KA5gj9Yi05YmVmvpoZ9s3VsZSDBbbtXv
         IsKDygg/Iw7I8HF7FtlCchL10m7MBCs775bzqnlpaFt5FMLnbZW0uTGsjRob9rQQ6eFn
         kE8BIcxaKsoS8SocacbnQihFWNZUHfp2wn09pKkZZl/beVVOdUuYtrUX77NBRMgrwrf9
         LwDGe34+YpiJ18FF/YSPzaBuzDkBiC8aMKJLB15w4U8jJXoVQuHrNdyRsXXzPAYexvEk
         nugg==
X-Forwarded-Encrypted: i=1; AHgh+RoOnE9XnDDaOKznihgdrZRswb8F9euMlpNp03ycuQcLdWp1ut0/6S1ZraQmlTCFm+NCq4NL6xm4Lbtv36z9INk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/WXWlNI0NWFsrjmCtQMv40QH/76SGbky5HgWiGaC+OEZ66mWa
	nnrs0PbdP3dBWoB/KfdxLsFAfzh4mXeFg2Yuydfra45/4aXnXXIm/fAmc7DctjHDlWqL8GNh80b
	0h4jZS3FYGKoC7dmXzJc0td6Qjgod5V5nNmS7MXLLCQPv1NcYUMncuzA0FXUJwfohboE52kA=
X-Gm-Gg: AfdE7clPlPQLbhJAiPPUTzU/xo0wsB9dtklNEUtnfeuwiOSMQB+SnjUop6Lvh8JL/mv
	WPiTtKyJ9sZl0Vq+eNbFfBT65kNK93Jnw4B708xf3yeEuIfpZFbgi3WJY0nhiHZQu4zIT34oiWo
	adrHvjK52cIk1BBk6PgOTITAc49Hvp/8VsPVurr7sJfF7pkQ5YjQ7ZGYPdrFEdRw6c4WsuUyhzp
	QsYNTrDKhm2HmV1+ZAiXYJVVPkisD/BIyh7bkvdTMs95ggaTMVIO0dntUxnJ+ZoPuaaPrAPUUyX
	mjeGLUE70vsHhzpzyU10+yoMAY1Pt0YSqE3LOYwAi7V/2vSgevKigcwIks+omA3Ao0tRJ8omKkg
	bUMjKISsuhzhZ9loK
X-Received: by 2002:a05:6a00:390a:b0:84a:6376:cf52 with SMTP id d2e1a72fcca58-84beb309d9bmr13004717b3a.28.1784418404443;
        Sat, 18 Jul 2026 16:46:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:390a:b0:84a:6376:cf52 with SMTP id d2e1a72fcca58-84beb309d9bmr13004706b3a.28.1784418404002;
        Sat, 18 Jul 2026 16:46:44 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af30befsm3312454b3a.38.2026.07.18.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:46:43 -0700 (PDT)
Date: Sun, 19 Jul 2026 00:46:38 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/8] iio: dac: ad5686: refactor command/data macros
Message-ID: <20260719004625.044c098c@jic23-huawei>
In-Reply-To: <20260716-ad5686-new-features-v8-3-ebb0051af5e5@analog.com>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
	<20260716-ad5686-new-features-v8-3-ebb0051af5e5@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDI1MCBTYWx0ZWRfX1tbRmtjkfiog
 6y7raQDStf+JC7HdCz0sUw4Vn/FTISAnrP4uYFdUCvAEkhkou+8Ot6+mM6JKkfYMJQyrg7ROtcG
 qgi96tITXLKzIQm9sgqtqGr9BGs5yu4=
X-Proofpoint-GUID: AwcPow39aoKthMebWF3D-YBlx2DJS3rS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDI1MCBTYWx0ZWRfX6WiV1NcfWGTZ
 Y3OExYm/Rl9Mds7OTqJJvlE4r0rhj6dRuy/pOcWft4678vYtGvWhL3smcetdrAyPv3AnrMyqfjE
 xpAr6GvCQKNClX/3HdLSkIgKuc8LHzq96ULeQdu/zRfOm7GY6OtdWloXfRKfIWay/OBmvMAE9zl
 MrsfHDr5P2Z6TI8t9maageSPVWEj8pCkRM9Zt6Xp2FcFFnTR9YNPAXlFTe5X92csNNP3K8Cczjh
 lL405TAAULvvRX6c4S22LQyeyemXrtxeS4Iu6Gpb8Xvgn4OkzR+zD3HMCF7u5yhcp1Q9cZD2HGq
 OpGpznahWouwTNN1IHBrWEgzob+06qwny1C7NuN6SFLNRf0tSFjJ5OiP7ZtjvV4nQ8KT3YCM+oY
 CcpT7Qg3b0cE47cKA5Ao3zyDD20YVPiMBwgreSWOd+qqZmbPTZfz+vheadALb4ZdlZSLB1ALl5j
 1Wt9p7O7OkN6t0bB9uA==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5c1065 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=x788Ep6gh8qEEuNuW64A:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: AwcPow39aoKthMebWF3D-YBlx2DJS3rS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180250

On Thu, 16 Jul 2026 13:14:19 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Replace usage of bit shifting macros for FIELD_PREP(), which would not
> ignore bit masking when preparing SPI/I2C commands. This change is a code
> hardening measure to be paired with the upcoming triggered buffer support.
> For the AD5310 regmap case, 16-bit data coming from the buffer may overlap
> with command bits if the data field is unmasked.
> 
> *_REF_BIT_MSK and *_PD_MSK bit position macros are renamed (with a DATA
> prefix) so to indicate that they are relative to the DATA field.
This is a bit of an 'and' statement in here.  I guess I'll let it
go but ideal would be to have done the renames as a precursor keeping
the focus in the main patch on the FIELD_PREP() introductions.

Jonathan


