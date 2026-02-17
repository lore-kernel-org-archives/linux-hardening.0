Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932ED254841
	for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369723; cv=pass; b=ODuDxDLE7atqvsqReaeW3tezO86pNVoJ2k6i/v2fJuaMiUbIa7LQw6LjZ7LVTIJDviTjwFsj1GeWVF33xZlkEHNXxdujMC7XQcdTnum1p6G0tcbkEj4cVPTL+pbasklYvWCkb8zpWhyezyj3UMqfDaJUSmY8T0J3nlzOTzeQqdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369723; c=relaxed/simple;
	bh=6r2/HzRW62rdPF5cC+mjlxhbT1Nklrv0PUlJYmr1Rys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJKa8tKjakFyHflkjcutLPiu3N1X1ZStboDRR0TTAhiGrl8bk8kVfVuwS8IM0i193Cyys9ZkBscvU322kzfZChEey1mszXqV1ocjpT7OBv+sAL7VEPjtuG/wYfuK7Va45fH3/NQ74VuS+AEPLKzrQz3nbRa3qhtl3PN3hPP0Bxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HuknjF3p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B9Lkq1uL; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HuknjF3p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B9Lkq1uL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HH7nGc1545005
	for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 23:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=LnanU8PAYceSWKBt+m+SEdZEojtqeWe2NeYl1HwNokU=; b=Hu
	knjF3p/1KoYNLudzRm1VJq6Qb98csFwOfWEvCSnXuCqjNufsBlkJm3+2mxD/v2ch
	whEkYmMPEwtsXK1jXmT8+4N2vN70jd8DPvPE1hzRvRfh+SofiMA8iSBWtmhZwEjc
	tOPtphayWdDEkKX124h4tlQqioSmbmEll1KepWceEek++K6vs5hSFfpktBRExeku
	dKfIfXITalCkoTj9ReZr/EwgxuqnVZhBo0d0081OQxuQqWWssrimNVD3PjkMFBuc
	th1xKaUR72JEtC/Vby1YGo1amsHnQ0vl1YaIHdnftPFoBTnasenfDnshzaugG6bZ
	RsNJde9ZmJqUxP5TQbJA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ajv5jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 23:08:41 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso5737292eec.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 15:08:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771369721; cv=none;
        d=google.com; s=arc-20240605;
        b=G+XfZ7a/Z5e2f576Uap3uKjzH27y2ShQMTOyK7CK4ZQ2EfqKvu/m2SUk9htc7R/Bvk
         waTQY2DCRSwYW6viBPjdDcaRsF8ok5yqp+S5J0R75tbM3Ic0xkhY/yD5DEgrPhzG1Fcr
         Ct0b6WPr37H3a3Gm/T808TZw6QnBbnJwlv/+u9hBJyeGLjmm3jw8QH6hpjYeKbwZm+cF
         z3FmP1sutrmFtdmUFFvQqq5tbCKAwqHAX0lNee2aHTinhU8CKs6dWNh9WtWVEq8+V820
         7Yfjdn6vCKhtI90tNoOmlVdZEfQ/GvghVlVe03K4S3K85eD5Iek148+Y6TexTdJ1Xoja
         q+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=LnanU8PAYceSWKBt+m+SEdZEojtqeWe2NeYl1HwNokU=;
        fh=bTGexlevrQZNH/Tq081hrYHjXRPC6ZChD5VgDAOdWZA=;
        b=iIeDhUFqps8vqesD3bwBUW5eJt0jYJ7zSW0SCXMKp5oCMbS/Vc+ZonUxsE7c9Fw/ND
         9bOnlxp67FGOFYvcP45zr4Bm3qMRpexJf7qCUMbOGfRbBAtExUicsv/OVi9T8rEDLYI3
         ZJtxIR2e6D9My/oWaTF0eXmqh7AhiiEVPlRo91fMSKobPRJpgqr94kPtA4qydMOj55zl
         QHOK7Lj+HUjR3kgP1pAXWyqVQgRLqEUUlOugEkbcCPcjjeDvhUUKoMhUNRZIs1b8K6gC
         7XQrxn8XtL8Ebp38cHhEQho8Gx8uMtk1Ygmmj+jb0uGIHE8DOlmejd6DACNojhTl4kqX
         k36g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771369721; x=1771974521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LnanU8PAYceSWKBt+m+SEdZEojtqeWe2NeYl1HwNokU=;
        b=B9Lkq1uLHa62QMlZ/LtHvo6ea0AO1Bsw2kpNh/u17QzTU/aGE8tE3JMlqw+cywn9mN
         HkAta8D5NYiOFD765aoj7TAhoI6ZEZky8b1JYNZOL6ZlzvTOiOwK/NNFvEe1Xc+rvCV2
         7z+5U34UwNar2ixLMXaIXjbDtDA50bxj9eoAjsSAQiIBN2Yn++2yqq8GLNg516dJ0UMa
         zzrtjCcALgp7hg8oAnVXheg1JyKsQa9Jfd4d1JLN2PVw3VD01vE54kHy4cb4VZs0+kdo
         XLusLaeO+aJNR8Lqx4ysg+Sz051DRmjP0BpAdnP51T+O/EqTBC+DlmP5s2TVsxQmcX5M
         weMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771369721; x=1771974521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnanU8PAYceSWKBt+m+SEdZEojtqeWe2NeYl1HwNokU=;
        b=cKWHIhpR2etGZWsTagR/t73sK/6/t7kFjKP5rN/LUIACclEResSpvKscJ9xGF2LfwX
         ag6RXPK9EaHAYkKmdmdfHKfTWcw3PyA3LJGxT5ibyQpABe2op6+MkCNh9G7/j3Cvbs3l
         KNxCzgiqG0FTo5AxHzywqrBdk8lYZ0GrUjsIYUl5cXbo1zpOPLgeoGAl6wYtNqaz3qdf
         bHkzXKcWyVqf2hkRBh5bnR6crXTdyjLs2p4ez4wRiBclVt2wESn4jnn2toVZpv4Z/zG7
         O/zockHNgnePrl83Alm8UhfUnTI4MG1iacpAQc8lg3x2cZW/Z3SXr2XcKP1KNFTOD39U
         s/xg==
X-Forwarded-Encrypted: i=1; AJvYcCXMz72EBdjIXktmlqaIcg87QliiDRFS4i5/CTUp8xk2s6aJPzggNxE7A8VmB4deEkLPvS6ObLQ/vtNflO2ERXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijY4eEngdOEZLSgwxisfXTMJqReWKINaha7gYJuhOSfxw0Sh6
	JQFZCIzdfOOVHKM5GAbPSkG+pnABYoLJU+Z/YeRzO8n3kdu5JIxD4QyVK9+ty2ZCUPibuyrdQGl
	0lXq/oz6aiuKRfNF0GZSxmpbpgMjrzs4jJ9APjwA1vz5vmcejnuYjUnFcUpsi5q/AyGPRMaXc6x
	09ShQp3wKTrfnIokvJ/akreXNgFqDkeuPnJ3BMqy/lb+//ig==
X-Gm-Gg: AZuq6aLqNq7jSIBSJcicztMFNw+XbOcYkw7T+LahWq8z+SlsyPEAisLqrdNry2F8S2T
	oRCOUPWK/459mtt6wP/ymH26g1yEs747z+lYRye2WcrpALI0yc2MZbbQlPBXAevP8TsBhg7KnXU
	/2xsmmlOr5vj0O1ITSp8i5ZpvVqosDK+jl7GcBxhwPAed1fRbxJGqcEr0RZkdU4YQG1TAroVlpm
	Qs4tQT1M3hMOEJL5c43i9ZXfEncBARgb+P2sw==
X-Received: by 2002:a05:7301:1688:b0:2ba:7ed9:1565 with SMTP id 5a478bee46e88-2baba125906mr6788259eec.36.1771369720930;
        Tue, 17 Feb 2026 15:08:40 -0800 (PST)
X-Received: by 2002:a05:7301:1688:b0:2ba:7ed9:1565 with SMTP id
 5a478bee46e88-2baba125906mr6788224eec.36.1771369720229; Tue, 17 Feb 2026
 15:08:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <20260108-topic-smem_dramc-v3-2-6b64df58a017@oss.qualcomm.com>
 <you4xijwc5g4ngcnhxm4ecn7opexnsdfayvd5wiiqpl7734r7w@bdkpjqmlzxre>
 <b2pqfrs2ptaoxxeanzumxyibmydsoiqslcsg6yrm4hihynowj4@mzazqnrptnyf>
 <hunbpvbfkcxzbnwr676z6fncgdhfumjedx7jp5izojusg3rj7f@5te77lmqcdaa>
 <cleh7dolqus3grexqfchtavvnj6wef6rlslgv3r7gesfuyxhs5@5b6z5gwtn36b>
 <nhgxvv5bm3bevq4qkqnew6gaqlwiaicrs7yjckg26fgwnffqj5@u2phabfukljx>
 <befc5600-5cfd-4134-928c-80e3b1b4102a@oss.qualcomm.com> <iqg6jpq4i3olwugnlnsczisbrbysxzik6otby3pgkv5uqsez3f@diwpjgf26mk3>
 <203f6f63-e81d-4db5-8ede-ff6695a847ed@oss.qualcomm.com> <i74iyesupz2elaoefyn5s5r53op5aifftcmsgktk2pyghozvwx@usg4hp4wrtug>
In-Reply-To: <i74iyesupz2elaoefyn5s5r53op5aifftcmsgktk2pyghozvwx@usg4hp4wrtug>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 15:08:29 -0800
X-Gm-Features: AaiRm52D5WXYL-x3xfhCjoZjU7AnJhPRmHPHx2Ez5oMG6KajaDiqGRMsuv65CcU
Message-ID: <CACSVV01D6u1B2d6ipd7cuomOhE_iGDBF84V8=v7jcm_5hJ87eQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] soc: qcom: ubwc: Get HBB from SMEM
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sean Paul <sean@poorly.run>, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE5MSBTYWx0ZWRfXyzzdk9DqwIn+
 luqjAfI3DhdNmyTvCoxtPqHeodBk+xe4QCOcliwtwYtqrdYxxDRqgUaDKZQKNpSDnHyO9mlOvxK
 77BgcUxKZiuJHP4GZJtQTIoWCOIlTvUuHMEPBXyXqUY1yiEP44k8gHWrgMNchMzd2tyue2AvhV7
 +UZ9vcXVbjYRv1rMhjmZS64nKdgib2HVvjw7iL1SsxgTR9fobYgO7kya7EofhDzWYB4RbzMTNwO
 QAoKmgOVb7YPUDtoakaQfwhepSEPetHMulEHb2AebamfbRxsaaXCZLmPRWEjowNdIpyNk7fp3wb
 xn3OAi+5qrfOVIxov/AJnbDJ3V6KsObXh9EUd1g8anQQKb4naaPRAE87jdX0SwiL4JL82IK9F8z
 kzu+MsVp4tt+b/5gqBZmxs3ouZLLYCzo7H3kk8B4U1a4QPeTxK5fhuyNUYVl9oQgY6ezXOOgpak
 k4HvfFVLarnlptpBUaA==
X-Proofpoint-ORIG-GUID: HYxRzKtgeDFA-D01-618tMYKRIyr9plH
X-Authority-Analysis: v=2.4 cv=BryQAIX5 c=1 sm=1 tr=0 ts=6994f4f9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8 a=-dl7yEjYuLqhyd9yoY0A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: HYxRzKtgeDFA-D01-618tMYKRIyr9plH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170191

On Tue, Feb 17, 2026 at 2:53=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Feb 17, 2026 at 01:59:48PM +0100, Konrad Dybcio wrote:
> > On 1/13/26 5:29 PM, Dmitry Baryshkov wrote:
> > > On Tue, Jan 13, 2026 at 04:31:15PM +0100, Konrad Dybcio wrote:
> > >> On 1/10/26 11:45 AM, Dmitry Baryshkov wrote:
> > >>> On Fri, Jan 09, 2026 at 11:50:46AM -0600, Bjorn Andersson wrote:
> > >>>> On Fri, Jan 09, 2026 at 05:21:10AM +0200, Dmitry Baryshkov wrote:
> > >>>>> On Thu, Jan 08, 2026 at 11:49:54AM -0600, Bjorn Andersson wrote:
> > >>>>>> On Thu, Jan 08, 2026 at 04:45:49PM +0200, Dmitry Baryshkov wrote=
:
> > >>>>>>> On Thu, Jan 08, 2026 at 03:21:51PM +0100, Konrad Dybcio wrote:
> > >>>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > >>>>>>>>
> > >>>>>>>> To make sure the correct settings for a given DRAM configurati=
on get
> > >>>>>>>> applied, attempt to retrieve that data from SMEM (which happen=
s to be
> > >>>>>>>> what the BSP kernel does, albeit with through convoluted means=
 of the
> > >>>>>>>> bootloader altering the DT with this data).
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > >>>>>>>>
> > >>>>>>>> ---
> > >>>>>>>> I'm not sure about this approach - perhaps a global variable s=
toring
> > >>>>>>>> the selected config, which would then be non-const would be be=
tter?
> > >>>>>>>
> > >>>>>>> I'd prefer if const data was const, split HBB to a separate API=
.
> > >>>>>>>
> > >>>>>>
> > >>>>>> I agree, but I'd prefer to avoid a separate API for it.
> > >>>>>>
> > >>>>>> Instead I'd like to either return the struct by value (after upd=
ating
> > >>>>>> the hbb), but we then loose the ability to return errors, or by =
changing
> > >>>>>> the signature to:
> > >>>>>>
> > >>>>>> int qcom_ubwc_config_get_data(struct qcom_ubwc_cfg_data *data)
> > >>>>>>
> > >>>>>> This costs us an additional 16 bytes in each client (as the poin=
ter is
> > >>>>>> replaced with the data), but I think it's a cleaner API.
> > >>>>>
> > >>>>> What about:
> > >>>>>
> > >>>>> const struct qcom_ubwc_cfg_data qcom_ubwc_config_get_data(u32 *hb=
b)
> > >>>>>
> > >>>>> I really want to keep the data as const and, as important, use it=
 as a
> > >>>>> const pointer.
> > >>>>>
> > >>>>
> > >>>> I guess the question is what are you actually trying to achive; my=
 goal
> > >>>> was to keep the base data constant, but I'm guessing that you also=
 want
> > >>>> to retain the "const" classifier in the client's context struct (e=
.g.
> > >>>> the "mdss" member in struct dpu_kms)
> > >>>>
> > >>>> If we're returning the data by value, there's no way for you to ma=
rk
> > >>>> it as "const" in the calling code's context object (as by definiti=
on you
> > >>>> shouldn't be able to change the value after initializing the objec=
t).
> > >>>
> > >>> And I, of course, misssed one star:
> > >>>
> > >>> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(u32 *hbb=
)
> > >>>
> > >>> This leaks the knowledge that HBB is slightly different kind of pro=
perty
> > >>> than the rest of UBWC data.
> > >>>
> > >>>>
> > >>>> You also can't return the data by value and then track it by refer=
ence -
> > >>>> as that value lives on the stack. This has the benefit of making t=
he
> > >>>> lifecycle of that object clear (it lives in each client) - but per=
haps
> > >>>> not a goal of ours...
> > >>>>
> > >>>> How come the ubwc config is const but the hbb isn't?
> > >>>>
> > >>>>
> > >>>> If we want both the per-target data to remain const and data in th=
e
> > >>>> client's context to be carrying the const qualifier, the one solut=
ion I
> > >>>> can see is:
> > >>>>
> > >>>> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
> > >>>> {
> > >>>>         const struct qcom_ubwc_cfg_data *data;
> > >>>>         static struct qcom_ubwc_cfg_data cfg;
> > >>>>         int hbb;
> > >>>>
> > >>>>         ...
> > >>>>
> > >>>>         data =3D of_machine_get_match_data(qcom_ubwc_configs);
> > >>>>         ...
> > >>>>
> > >>>>         hbb =3D qcom_smem_dram_get_hbb();
> > >>>>  ...
> > >>>>
> > >>>>         cfg =3D *data;
> > >>>>         cfg.highest_bank_bit =3D hbb;
> > >>>>
> > >>>>         return &cfg;
> > >>>> }
> > >>>>
> > >>>> But we'd need to deal with the race in cfg assignment...
> > >>>
> > >>> static struct qcom_ubwc_cfg_data *cfg;
> > >>> static DEFINE_MUTEX(cfg_mutex);
> > >>> const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
> > >>> {
> > >>>         const struct qcom_ubwc_cfg_data *data;
> > >>>         int hbb;
> > >>>
> > >>>   guard(mutex)(&cfg_mutex);
> > >>>
> > >>>   if (cfg)
> > >>>           return cfg;
> > >>>
> > >>>         data =3D of_machine_get_match_data(qcom_ubwc_configs);
> > >>>   if (!data)
> > >>>           return ERR_PTR(-ENOMEM);
> > >>>
> > >>>         hbb =3D qcom_smem_dram_get_hbb();
> > >>>   if (hbb =3D -ENODATA)
> > >>>           hbb =3D 15; /* I think it was default */
> > >>>   else if (hbb < 0)
> > >>>           return ERR_PTR(hbb);
> > >>>
> > >>>         cfg =3D kmemdup(data, sizeof(*data), GFP_KERNEL);
> > >>>   if (!cfg)
> > >>>           return ERR_PTR(-ENOMEM);
> > >>>
> > >>>         cfg->highest_bank_bit =3D hbb;
> > >>>
> > >>>   return cfg;
> > >>> }
> > >>>
> > >>> This potentially leaks sizeof(*data) memory if the module gets remo=
ved.
> > >>> Granted that all users also use qcom_ubwc_config_get_data() symbol,=
 it
> > >>> should be safe to kfree(cfg) on module removal.
> > >>
> > >> I really don't understand why you'd want a separate API for hbb, if
> > >> hbb is already available from the larger struct *and* if a driver ne=
eds
> > >> to know about the value of hbb, it really needs to know about all th=
e
> > >> other values as well
> > >
> > > Please take another look, qcom_ubwc_config_get_data() is the only pub=
lic
> > > API, qcom_smem_dram_get_hbb() is an internal API.
> > >
> > > My goal is to keep having UBWC db which keeps const data and which wh=
ich
> > > also returns a const pointer.
> >
> > Right
> >
> > So if I understand correctly, this is almost exactly what I originally =
had
> > in mind in the under-"---" message (modulo having a static global ptr v=
s full
> > struct instance) but I failed to express that I wanted to keep returnin=
g a
> > const pointer to the consumers
> >
> > So in the end it's
> >
> > A) int qcom_ubwc_config_get_data(struct qcom_ubwc_cfg_data *data)
> >
> > vs
> >
> > B) const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
> >
> > I think the latter is better since we won't have to store a separate co=
py
> > of the config in each consumer driver (which the SSOT rework was largel=
y
> > sparked by), essentially removing the ability for any of these drivers =
to
> > mess with the config internally and make it out-of-sync with others aga=
in
>
> You have my vote for the latter option.

same here, B pls

BR,
-R
