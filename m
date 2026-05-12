Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EDC3CC7F1
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602887; cv=none; b=pqdRRvzB26C4dx8G0IRuHPN+QONNCAqVM7UArwfaxtXf9uRmKf2pzh6BQSiJ3kJRDGsOfZzLIk7SqZ3Q/gvJH+t4ryVsfibD1jlmBMnfT4OG6e1Gr+cQDU72DCYyNYezbe4jpvK3+ABK9SJtX0PGzii9geEpLq287kp+skfqXN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602887; c=relaxed/simple;
	bh=W8EalF2KkcceF4p6dRKK5F8ZTk64dxzj5Z1Pf8+6dEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uue3asVNROpmQL+xIbxEUmZnXW/WD3LcNOPt2owVupFIBfG6V2Gl7jERTKIDlG2o8Yw7A0/qloaPII5avQ1QgwJ+4szDZsDaTC4Ing3uNOFV2soodbuwuJWY+Lt2nq8Q4SSuFgmxzd8KLJfXikmgNo4Hp3aSJv9HwTTZRIakid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C6lhApsU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gDzRcl/N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6lhApsU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gDzRcl/N"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CC4SLF3320970
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 16:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EFl7j0YKunj2Vbw126li5xqaN5v5D/S65Q3oNJTH0o4=; b=C6lhApsUTArwqNAV
	x0Cuo7+aRf5TO78dnjCnLGJDdF/4BAKGX+8/dlcyWrumNGQgJW5caJN9jmzS+oSk
	rxLRQzgDVNMVAp6292QK3rbL8CvE/5YKCk6cCYCa6vCsNnBt9vSLQy2Piv813FPK
	ErG7G5O6CzkC6yVJIRl5bQpOyJua+EQnnGEp4Gs2DI7F4Iw1HToCQ7QHN10hoFpP
	FQShhatWaE37ozMBWDP7ubUJwum7yn3CLKSgok2txbBgnhlseN/zKBAXmsWTpkDj
	FIARs9stoletv4+cy3Fc4w/uSsZZxs7jy/2+v6IV0wU5BF0ksO1AqpdMWA8V2DjA
	5ibRAA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43w1s01n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 16:21:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2fdc19ce995so1368719eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778602884; x=1779207684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFl7j0YKunj2Vbw126li5xqaN5v5D/S65Q3oNJTH0o4=;
        b=gDzRcl/NtMcPKHnzyQ7EB8gprYKJfQuLrevtOViHOAx2O7RPcfGMyPOG1ycrzOGjcy
         PyuGU6s0S+c/v8XWy2MckO2yepSJ2de0yYH7LN0IIwERgjaFEQmCRpqyNfZpjJOO4weI
         J7cDqmV9tUuDdMNVKLK4JSNfeqrnI8Q3fAaWfDLZPiC0VzN8k8+eq1N9tQI/5asBdBlf
         AbF/qSByjKe88Hlp5dj0rSbdI/QXPhZlZnZCNLMKveF1rFS1FSM3+lgW9txvU4B42vOw
         qCWBgWlG3fV8w7AxgcCnsAI9pvKJVsY7chKNZROFCoGBjf1Qggbr8EN4MJ+83DfS/ptX
         h4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778602884; x=1779207684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFl7j0YKunj2Vbw126li5xqaN5v5D/S65Q3oNJTH0o4=;
        b=f3t2pBG95GmBUhOV1Ao2MMz9OGa/ZU6m0v91Bm6pEmgW6DEVE+4RiWvolCYAc9Houo
         d+YMmlnfTDLunqFGuTfc+l/MLeU8dX9HS32LqSFxgmg7xQmsBjoWWlxv0U/WtMMWLUxa
         Vx5KUXObe1HWoh19LmPVkX8IBVvycVbzV60vdXREYZa3IVl9CDTyL8ZYSfZoqsM/kV6x
         QT9WMsIXtWBeOwleiUDEZQfW2cLC4TTPh+YGczjlw7FeTw2QaDl8x0vKYJA+fi5AOlPF
         yIaSTmznpAFewKe4XKs5WyfzBwKeR/6KlGMHob4EVv/v/8WDlvqntyfPrMmDrAKQS5Nf
         383w==
X-Forwarded-Encrypted: i=1; AFNElJ8c3pCnlcCj7sxfP782XN7exIRLaiFi21RCBTunpqi+g1xFFVzi9Yy5nyOYnZxKuRHR8zyBqlyQDX1NJJ6P0PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNh9yZ1hAHEMHw8yTu+r5JajR6iW6ichiFk6zMZsbO1yTkC9Ed
	c9yJYVqFoX+j2z7XWD7QL1SVKB4jhxACI31qw8N37zHUEn5wYO7bT9bvGY+hazKbfd8p0e9UeAZ
	NTxV4PYT0NBe3RKAcUM1oC/chaFub5XJnovNrtb4mOidV7i22+Zw0ZgPpJHCaYXpv0KP+Zbw=
X-Gm-Gg: Acq92OG3qwPZQrYzOd3EDi2T8wGPK4ZE+FC0SAmKTHe0ndYxz8MVki7HRQujL0JWnWl
	OOCFLRb2Ciy4AVzxU66siBpUMj0CcwWXqWp3nvKduO/Zr48rv0uPSMUfW3ykm3KQPxfu1j/+PKk
	pm1JBv1W1Kf+MyWtmsidWZ37XsF9xAtN+g6s62AJ6KPMUmAC91P4GxFbAHTX5Gcz8NY00gWWLcZ
	95oRa+AG/Y8353/Ej4f4w+xhiasKPa9bZgrZBYXNMr03P+0qfo7QdQ38wHMtLb1kKfEH3DvCLHd
	6eH+/hlnYKemmexiL7d9lWyP7rYXQOjj4unxmA5LTrnrKp5ovrqLs86EBM3G+HT7NLH1UNrPDjC
	ELyr8A05zVq/64nX0EI+5LI8qWKv1mmBebbrNyFGU0e7rp0lKIjHv5i0tTbSUf51sRI5alG6wml
	4=
X-Received: by 2002:a05:7022:458f:b0:12a:6abf:ab1c with SMTP id a92af1059eb24-1333b1b9466mr2440522c88.11.1778602884514;
        Tue, 12 May 2026 09:21:24 -0700 (PDT)
X-Received: by 2002:a05:7022:458f:b0:12a:6abf:ab1c with SMTP id a92af1059eb24-1333b1b9466mr2440476c88.11.1778602883547;
        Tue, 12 May 2026 09:21:23 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132781103e7sm23886722c88.1.2026.05.12.09.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 09:21:23 -0700 (PDT)
Message-ID: <8f2eb932-f70b-40d1-a5f8-6430fc735f71@oss.qualcomm.com>
Date: Tue, 12 May 2026 10:21:21 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
To: Rosen Penev <rosenp@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM CLOUD AI (QAIC) DRIVER"
 <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260401220643.12802-1-rosenp@gmail.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260401220643.12802-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: svxFbhSUpojPxjS1pljaM91QXZFI3xwl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3MCBTYWx0ZWRfX0nsscRT7TLGb
 ZDD13o1a0ZR+0MFFBOryfMJlUOqhcQpeeESigApHOfMMKavBmizybnXqSu1gScAX+BwotjeyLjR
 pFkiq0hMN87KRYTV4MFbKvgwmnjPP5ful5EUajuQWBRODxiyoycQz6xdLL8ZHCztqfHtnPi4Lhe
 mPU4pu89vCWwcQOVybRXRWf4+6sMiPJCQqizzv7ugC9mLjk5pyTbHEl16xbkBWOm3tYpfNXyg9d
 HYZjoqT+uHQPT9RJL5d6c7fkV56ge9QPl1u3vJ7V9c5z2uaAcoHPARGYSZx9aymn60b2MQNnn01
 taa8pHVvhGxXx4eZSBT70XBsBSsoHi3+GeQQ4y1H9JAaewXnOQ4H11hLpwBoKZovbs4PtZ5OBTD
 D59o/m1MTjKdjA6AVVd3m+kCXr5+MqcfBo2IWUOerfAQ+B5I32KwEuX3Ko5wHtsItsryM0zHTIh
 Xlj5X9RR4yiJEt/1mrw==
X-Proofpoint-ORIG-GUID: svxFbhSUpojPxjS1pljaM91QXZFI3xwl
X-Authority-Analysis: v=2.4 cv=BoGtB4X5 c=1 sm=1 tr=0 ts=6a035385 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=1lcS69py3Ix-9TsBHUMA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120170

On 4/1/2026 4:06 PM, Rosen Penev wrote:
> Consolidate the two-element allocation into a single allocation using a
> flexible array member. This reduces memory fragmentation and simplifies
> the error path by eliminating the need to check for allocation failure
> between the two allocations.
> 
> Add __counted_by for runtime bounds checking.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to drm-misc-next

-Jeff
