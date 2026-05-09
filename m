Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394036606E
	for <linux-hardening@vger.kernel.org>; Sat,  9 May 2026 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338058; cv=pass; b=dXUSHzhKU32ukqFQSKS0KDkwpYATCfojJaq0jVWjeGi6vi+4zfI3EThpJ1lf4G1PH9BkcHhXZZ/K/44JScIr9JcZAjM+q/ivIiJ0n68Ax1QCflo1cbTsoL7JQMwGGWSHni+kC+vWe5cJXC/Jr5XZ5oTp3WsrmbDWY4STWC7V0no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338058; c=relaxed/simple;
	bh=jBVo2t6J+YaU7d0WqCTZn/YK+PK1uQ9DS2xi85AzFOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLklPy3GJZgk51MVRD5xeuxTUw2TIMaHUhVOAjDNz36B9emkZsp8+v52YLlclIjOV6SdCT0y74QVd1CW8u4ZZOYa2EK6hZYJbCdNNBoyU7pQsc9i5CqnzCBxUr0CdifvnHro6dMpVuT469U0jW8B/LFf1QO7Z74RCTUsvLA8sP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iJozb2yH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U4wS2VGs; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iJozb2yH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U4wS2VGs"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6493QQlf2090152
	for <linux-hardening@vger.kernel.org>; Sat, 9 May 2026 14:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	27C2/Rl3KFni2vfVGZkQu6bndldr2xFN3AQbTDjKonk=; b=iJozb2yHyqY02BDD
	6FeGs+r+I0kL7W9HHk9vlyvm1dl7BBB/dgpyERGTUgp9U7+o5zLwiAdC1ld/R7KU
	KqBlZundHpk7YvXPRTZHkWsBobuSXcELNk42Kc13Vg/UoY6Q61aUnd93SzjZTweb
	0zKY54sY8DIz4sFaZqFUFykUiZFdVib40m970KcJC2gFNlMm2AVBMzM5jzhuSUZK
	lm6cFxUAkEqorqcF7GuwEv92VVYoW8DppXJAoQpXedg8uCYkHez1hZKyxdlcsQv4
	nSePXMtfIHLvuqcTN+orDGQ3eyMhzlj99T72fJqGV/YS2m6wAcKKiWCk5Q6LVQOn
	iLc5ZQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1w0uh4nj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 09 May 2026 14:47:35 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8bc140520c7so41089516d6.2
        for <linux-hardening@vger.kernel.org>; Sat, 09 May 2026 07:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778338055; cv=none;
        d=google.com; s=arc-20240605;
        b=YsJ7X8qZJuZBh3YaD3zokBpXVxMCrjo7hODOYy+F3iwXUF5Cu6CZQgmBoLDKiemT1I
         pxQxjGFCMhovORXm9CQuNhfa8gpZ5PCX36MDSFN5IRlGzGU4Hyzmy4enGgYYfIzxSLfZ
         7xOTAy5Z1f3o1BV1758z4diVirTJGDFuvt5jl9gpuO24yIEzprBcaAtBR5CjChIOBVjq
         5l0hf8a9548EBLmdQrdg9EwFrQuFAqH6XXXwrKsiSDm/WU420AS99C9hKI+B/9cy6Xxg
         7s9x0YMRphazH/hhSa6fZVLJ5O33lOnu6I1IR5T17Lkr4f0KcHMMmGj6B5m8D+yqAhbO
         IVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27C2/Rl3KFni2vfVGZkQu6bndldr2xFN3AQbTDjKonk=;
        fh=/55ufV0VNJDsSznrYF8XEsx9ylby4zBVTzvjMHm4bbk=;
        b=jFLNn18tKBbSv5HdD3yiUGPcQ96eIJJVHaRUhb4tx4sveUTgmL1bgLoHvwD5GSuVDC
         afyyOnxKWHg0ZoQeFvUZSlq9CgSco6b2o+YGhq4EH5yORPmcMplg1ZIE95yKkB/Ce22I
         Cloj8lIoOTwQhVuZLjA+xJI51B17KDs2hxY/hcR4tVJbVGiKZGM0dsYQWrWddUWXFSoR
         14yMuxrdncpkee6rgO/cQxQrvAvucfBG5eDcGXjh42adA6f5uaeuI7kCK4zQLxWhnMzA
         n7cCTgBy5QnPgu7iYOPq8xk3PEEkus60Zhyk6c7lAYOOD7wpPfcRZEBF6WKlGjuQh3sk
         OucQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778338055; x=1778942855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27C2/Rl3KFni2vfVGZkQu6bndldr2xFN3AQbTDjKonk=;
        b=U4wS2VGsZlrd8TcXF2xmeTmWxL0WYAXceKNMRJQYiNThSXeJeBkkVXUv5nK4sWGsSn
         DMJKsY/s4uPcM2k6wY35AOgmqwIUOy09MAWazq7yfeg2FtyQ3CsuLg3iJWofzpF7vmAP
         mA2mbtkY0d2APZnFHD7+7I6uTBMBBVOYpLrx/t9oKEFjRp1lc2JiP8VBEOpG1/Q8JC9K
         0dYpkldFHfa2ZbXzFozQtv07JGKLqgLu0gNB6sLxjHVrLNxsEQWu1AwbUAlviy4fAO3e
         XB9d8wwUm/Ed5IroVOjzqRphbMiQ7pN/tc+k5FxE3x9AZLW7FhmdmVcfxCmOVpySeYfG
         AFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778338055; x=1778942855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27C2/Rl3KFni2vfVGZkQu6bndldr2xFN3AQbTDjKonk=;
        b=STN6ZUId1k/WoQnNrS5LEi0rUSiFv1+QsE54d2koua3750ORIhGUIZ8h9yrH3l/e48
         qzip7pOiAjRyOMbKY1SozLDCBb4irrZ56A4F0bPMWA2kwutQlp75xEPyGSy+ipVOSOTr
         Znx2xz1eZxThLcvCo0tS5yV5vTmUEr3BGWu+8Uh0ZTRHam8q8P12XpJ5Q+WwIMt0omS0
         YlbnCO1Hot+9VCYwfyJnucRd+l+r17ghMSOxv90Th+KdRDsaUAY45CD/EPWngOz+X4hy
         0hnipGONSwp9EIr0kh2OsKI04gIDRH5X8ykAZfaJVoz2GgioV2RGteISyWvwVtGZ7TrA
         RZMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/G1xdlcOV0fJBKducGU4/dLmMxb+UT1J5DWU/dQT/RHL2t7FJI6UaoWGpfPSATFfjOEPzQxTQkYNquyh3EVqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJG6/r4KArrwTl9cwTjxt/jDnVHixQrEu5QTd3MzNetmwGdmjZ
	JbTRWCf92uSiXq4SEyOLHMyf7XhRnETPmbAkJsuXXaNqzM/iktiDlCt/qXnIX4MnRZrluJ9Ewg1
	ZpSbQQ3dXrsCtoF6WJJDIs4ygxdZbSEzjt9LCwqGYTKJSrX1YDMvInm78zX5+6WrbMivkGf9KWs
	ETjibKi79XxmkuWjLozfzWPadPxKSbXC8VznryjuYft8wStw==
X-Gm-Gg: Acq92OFw8d20N+bZH5/6Tm9ZGJD6FIArdydBo8gjY/CBecWp7kmzBK3Jr3TUV0uIQi/
	4eeetGSWNZVrKg11SZnBHQ6AnaZOcs2VBVDyZQw/RLJc44ltPECziw3src+Q0TMycvb9OcE/76n
	tI/xrsBs2eVSB0cttNcj+uitL5OO45BMHfFncmkacFpHfp6NA03Twobtinav3BeUDl9WcHcRB+2
	4WfBUYk/a3Uk+C602kD0xxbGPcajcWSQCX+FzJC
X-Received: by 2002:a05:6214:2262:b0:8b1:f297:a54b with SMTP id 6a1803df08f44-8c1a30d0af2mr40303146d6.18.1778338055242;
        Sat, 09 May 2026 07:47:35 -0700 (PDT)
X-Received: by 2002:a05:6214:2262:b0:8b1:f297:a54b with SMTP id
 6a1803df08f44-8c1a30d0af2mr40302706d6.18.1778338054781; Sat, 09 May 2026
 07:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
 <20260508-camss-isp-ope-v3-5-bb1055274603@oss.qualcomm.com> <f6121050-3b27-4651-9fa9-9300ad299df7@linaro.org>
In-Reply-To: <f6121050-3b27-4651-9fa9-9300ad299df7@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 9 May 2026 16:47:23 +0200
X-Gm-Features: AVHnY4IkAq7SY7Hp6OxCQcJXDEy8UMWZq8MP9OmoTi2x5Wfx0FQsfdjxEJtkApY
Message-ID: <CAFEp6-3oTtRXk__bnZ2xFRJ=ijnep1arhekeJkOoRBr+P6A_bQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] media: qcom: camss: Add camss-isp-sched helper
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        johannes.goede@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Zuur7XPzggVe2LGWSkyaDgSCqO27tjnb
X-Authority-Analysis: v=2.4 cv=asaCzyZV c=1 sm=1 tr=0 ts=69ff4907 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8 a=KKAkSRfTAAAA:8
 a=5yXcwO-DJp0L547LFbcA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=D0XLA9XvdZm18NrgonBM:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Zuur7XPzggVe2LGWSkyaDgSCqO27tjnb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE2MCBTYWx0ZWRfXzsOjAF1WCs1d
 3QU+Bx3zESm+bDxstmtbzFWgADMjWC9grLfgYRwOtl4jRGtW8iYxjYNOpKKhUK8RrofzsObBagt
 0BmNwT7zrm5K6Pttyj+kqlMyykvQScmOVah/0RnsRaR1+E+cf5Iac7tYXUSG7PzwNIYaeuezytY
 2j6R8JcRNioKr6Ifsh04CLC0+2E5KpkNNU+Rrvo1ggsmhpct6ASlVirM6n3554bk7zhR2hn6R7g
 /lR6pt8vNMVNxnbwZOL30mTG78UcqPaT+JG4oCJER6U7/NfXhChzPJ19MFv9Oi8e8Yl3iv/oD63
 aYvBNQJ4FvpYesFZUMyMu2QwzW0NqHO0SVYncApwmrlQ0iqAT79qalxPYsvtNKyYdpl8lhDJx+l
 2sXNMcxmsMuBSmK/FksJkf/RBWzc1wgjrsLju5nnmrmuCXcUrTiQfQbVrHE0rCdlNu1eRmJzUYJ
 1g5omVlQe9Qe4UOzgFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090160

Hi Bryan,

On Fri, May 8, 2026 at 12:06=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 07/05/2026 23:49, Loic Poulain wrote:
> > +/**
> > + * struct camss_isp_job_ops - per-job operation callbacks
> > + *
> > + * @ready:  Optional; return %true if the job can be submitted to hard=
ware.
> > + *          Called outside the scheduler spinlock.  May be NULL (alway=
s ready).
> > + * @run:    Start the hardware for this job.  Called from workqueue co=
ntext.
> > + *          @ctx_changed is %true when this job differs from the previ=
ously
> > + *          run job (i.e. first run ever, or a different context took =
over).
> > + * @abort:  Optional; abort a running job (e.g. trigger a HW reset).
> > + *          Called from process context during camss_isp_sched_cancel(=
).
> > + *          May be NULL.
> > + */
> > +struct camss_isp_job_ops {
> > +     bool    (*ready)(void *priv);
> > +     void    (*run)(void *priv, bool ctx_changed);
> > +     void    (*abort)(void *priv);
> > +};
>
> I'll reiterate, I don't think this is needed and is overkill.
>
> v4l2_m2m_ops already has device_run(), job_abort() and job_ready().
>
> :g/ISP_SCHED_PAUSED/s//v4l2_m2m->suspend()/resume()/g
>
> This seems like codebomb of a parallel implementation, which can be
> largely covered by existing v4l2 stuff and if not then should be
> justified in v4l2 as a new design paradigm.

I could potentially reuse the v4l2_m2m_ops structure for these
operations, but not the full v4l2-m2m framework. The latter is quite
monolithic and handles everything, buffers, queues, job scheduling,
media topology, etc and is primarily designed for simple m2m devices
(i.e. a single video node with two queues). As such, it doesn=E2=80=99t
really fit ISP use case.

Instead, the approach here is to introduce smaller, focused helpers to
handle these orthogonal aspects (buffer management, scheduling, etc.),
which aligns with the direction suggested by Laurent [1].

The longer-term goal would be to generalize these concepts at the
V4L2/media framework level. At that point, drivers such as OPE or
mali-c55 could be adapted to use the common infrastructure.

[1] https://lore.kernel.org/all/20260414084259.GC4061@killaraus.ideasonboar=
d.com/
