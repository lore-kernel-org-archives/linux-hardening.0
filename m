Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8A3D47A9
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169865; cv=none; b=Ef3hicT4GWLM8Rcj9yAciRDQnUPUhz65aQ1JuXyk5rfdywIXKMXxLYDcBEEVwdsehEEpxWaOZ83sJXXNARiedi+9QcN62rQVB/fA65aFihmMOC9pzwF6ZstbyBhhur8TRvqgzVskCO94qxcWyBkJTLweWNWbNncHWNS4Wf7Yw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169865; c=relaxed/simple;
	bh=z2S0O+Z6SKjDTzHmNBzLfCiFcj/fjoPQu0kmvFQE9mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hafIJi+gNHIgE+2FuPqma/Tm3s04o2izMpiN0zd23ddXh+6uI0VS+4ekHF2t8HQePhvXJX6DrJcxU2Ey1DU9o8X7oOA5Gl8lYo+BQw6LiBC7uaTJaqVMckDbVMsE0IhZLmkQ3cCJVF79C3ZYblDmJI/pndY1GJlC1U3Vu17nopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZqA4XKt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H/UEqsj/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZqA4XKt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H/UEqsj/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632KOtYO2707214
	for <linux-hardening@vger.kernel.org>; Thu, 2 Apr 2026 22:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6UFKNSmLGChWbcHC+BOvNrJhyweshXNps/7M9u5hOUM=; b=CZqA4XKt5yhWCJ4J
	psylQCzfLI6KnBTytFRESmxSBv5qf3fyao5e1/MBTsTIujIbrhhFd5d1jyHCEQOf
	SBLJJjTu5haDqu0nWpqDO/FEiGJ3n6FnjGIv8TJE0CndxXGAmlTY5kt493jfcae5
	fKZb2rC+i3vgHQbggTM1hCAq6cC3rddGnd44LUMjFN8wgZNXVPh/rolI1qSSVZOb
	2bgIfCDqc3UL7DYIotLw9MZQQO1T+7g8lxVcvklMSfT6UVhVtGFUBlZKUni+cH7W
	1t9Ii5gsiqpKCM9r8m6IGIT/qKpNYol2NKT6Zozty9xTASY2Tp9hR4FBaSiaFZKB
	ctYIKA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9yfjg9x9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 02 Apr 2026 22:44:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1597778eec.0
        for <linux-hardening@vger.kernel.org>; Thu, 02 Apr 2026 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775169859; x=1775774659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6UFKNSmLGChWbcHC+BOvNrJhyweshXNps/7M9u5hOUM=;
        b=H/UEqsj/Q3CTMJtmlEdZ83svffwVo1C6IRvu2i7RNsDq94BbabBOsKwcATZV6Pm/AG
         rWjOCJp/qHW21/BOEZVpCX3nmzg+DzLRmOz77j1LqR5gNvYaPJv5zLqFdFXDcBs7oC/T
         VQRQqqQK2nnWWRsnGvLocTBH07haxuHV22pnhx2jueFhfiOjOGpypurhxSpeSJZQAgno
         XyIbwNCmYtvz/JmCw13xtRL9Tx0NGo5PbA2NVYhlglTzg7UmsYsaZPFJIHw+KPCtvfzM
         VwXCScoK1z0xMG5Ejw7FjBWy8lMFZ4PmmDOiVynMAp9LTXRbPkB0sEt6XDyfLqktfBsH
         T/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775169859; x=1775774659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UFKNSmLGChWbcHC+BOvNrJhyweshXNps/7M9u5hOUM=;
        b=WsRTybaO4TZoxjGatMiLvgkk2JkMBdzZ2qaOnPQXg0yiM7KEEFCi1yExRWLsE1R5Oy
         KaGgH8YdSuzd5TC4mznYGHK+no0Dy3AdHk7l2nqPuBPszaUmv/h80+HYOb8yQgYCqNGb
         XWaQ6LFpJMdiBMxfp4t+5pZqKL+BI2vK3ZMS3WFX4WdmP7uVywnlDv5G36qJJ8U44zph
         QevCPi5XjfHV+9G4m4R/h6nk1jL4tqmXNUMGCT9TtUBlx3wkZelZE9MEqZKztmC1PyVo
         /qw202YUpOVtojI3LL80rtBT+LBETpYeeEl+d1/Pym9xq/dD+a5ebX4k11k/oCDiv8uW
         BFZw==
X-Forwarded-Encrypted: i=1; AJvYcCW9TETRd4O7M2mHpjdKYN7cmdyfVjHGWxDSAcS5YNV1VvYkcqXiqyNSeXk2LRTtErA2371431tCvoxsWVED6cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUkAoBfk4SgNANF3caORTwbY5lWNIVop82xGZtia592ifOqat
	JGevoeLIm+Bo+jHI39YErTAgLfNdd/9wT7d7rtlS54gSZeSxhDoLxel27uVkVqXsONeDhcbZ1fg
	8TkwdxCs5kfnnNUQPoHItUozGowH05aPgcAPyD4kRyItxkNhGg2psRsDVNLzMEcqbfxBoTA==
X-Gm-Gg: AeBDiesECwjSBPTbMJg981epIgww8iPiyiFHaWiWH9JZjZcMNlA7CZBvB2EeYWHVVBv
	w4mMF7bk+uon/VJxA6CfUpmUDBJ5ch8pndcP0sIUCJAuswTFvX1sxGShbhm3Fnu8xf+Btt6ieby
	9n9STyFiwKuZzsUY9kWZ6Lye/Xby2FFzV//d1KK/1NN7q94jckyfnyGfam5XnBNYwoCYdTqtqjp
	X4TFjUFJPCEAkwzd4aIjvr6p1zPQ6go3zND8wk9VIMVqzxP+0HrUTKZtdOefvX8uUbcOFc/pzbQ
	xr7x36IN0EnbyU5ikQM6L7ek4BxoTZ4Qh8l1gj53V3ZelxMdSFdVVLjSOSvNjXerWqY0O7zgzI3
	07Eoggw+CTqaFPbPP6Qq7QNI3EdT0MpqYMUoCuJb8k+NeiB3pY+EdJLwj3rpXXDdK7sU41kmLTA
	==
X-Received: by 2002:a05:693c:3005:b0:2ba:6819:2e9b with SMTP id 5a478bee46e88-2cbf9503894mr507959eec.3.1775169859349;
        Thu, 02 Apr 2026 15:44:19 -0700 (PDT)
X-Received: by 2002:a05:693c:3005:b0:2ba:6819:2e9b with SMTP id 5a478bee46e88-2cbf9503894mr507940eec.3.1775169858727;
        Thu, 02 Apr 2026 15:44:18 -0700 (PDT)
Received: from hu-fruiz-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cba62d7590sm1943062eec.24.2026.04.02.15.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:44:18 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:44:16 -0700
From: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] dt-bindings: cache: qcom,llcc: Document Hawi and
 future SoCs
Message-ID: <20260402224416.uia466lzbgef77oz@hu-fruiz-lv.qualcomm.com>
References: <20260401-external_llcc_changes2set-v1-0-97645ede9f6a@oss.qualcomm.com>
 <20260401-external_llcc_changes2set-v1-1-97645ede9f6a@oss.qualcomm.com>
 <20260402-dynamic-axolotl-of-tempest-eeeb7c@quoll>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402-dynamic-axolotl-of-tempest-eeeb7c@quoll>
X-Proofpoint-GUID: QlO3GQDBxlETk9Guiun0P_cEEvquk4X0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIwMiBTYWx0ZWRfX+5ypUmIoOwBP
 FX0PsKKVJzR4vI07hlGDJQh38r6d9s4kgujKPAp6nFVUIdnuTCz0GiPpW4DjKpio3AKVD02t7nW
 Q4No++YlIsbn6MGCLE/2KMnHxHchi4C/EzZI5C67tiBa6LvHVF2/BkhFliCNSWBOgMW/F9K40Y7
 ICxrFyHx024WxlX4rXbpy9iUvZIJhUcVML4DN+BsLfIyQoXS3OKFAXk+aDX5aU/o/kOc5wxr1cJ
 SgkEkUM9XtzP0JBB49miX4nyGn9TwxuTBwWaKYsUaDFbBOeIAki7/AlWsw5nYMtVtLzeNCmmS9x
 pBrYFH/Jlc/WiF/7/IUbz0D/4b8n5LixrJN9FKVxbR/0fE05aYeKTyNsVit+VZvUDaKxyOOz2xu
 s6YdX2Z1v88+KuyiCBqRp1VgoMpu9peP0xcwEK5phDVvCjQnSJl6Mx40y4Zj7tq3xg768Lh6Zwj
 zdvHGmi7dvynyz4BoUA==
X-Authority-Analysis: v=2.4 cv=OrpCCi/t c=1 sm=1 tr=0 ts=69cef144 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=WGe_n8jcfaY_jPX_giEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: QlO3GQDBxlETk9Guiun0P_cEEvquk4X0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020202

On Thu, Apr 02, 2026 at 11:19:42AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Apr 01, 2026 at 08:01:34PM -0700, Francisco Munoz Ruiz wrote:
> > Add documentation for the Last Level Cache Controller (LLCC) bindings to
> > support Hawi and upcoming Qualcomm SoCs where the System Cache Table (SCT)
> > is programmed by firmware outside of Linux.
> > 
> > Introduce a property that specifies the base address of the shared memory
> > region from which the driver should read SCT descriptors provided by
> > firmware.
> 
> Subject - I do not see any future SoCs in the binding. Which future SoCs
> are you documenting here?
> 
You're right.
The "future SoCs" wording is not justified by what is currently
documented. I'll drop that wording.
> > 
> > Signed-off-by: Francisco Munoz Ruiz <francisco.ruiz@oss.qualcomm.com>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/cache/qcom,llcc.yaml       | 29 ++++++++++++++++++----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
> > index 995d57815781..ca1313de10ca 100644
> > --- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
> > +++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
> > @@ -11,16 +11,17 @@ maintainers:
> >  
> >  description: |
> >    LLCC (Last Level Cache Controller) provides last level of cache memory in SoC,
> > -  that can be shared by multiple clients. Clients here are different cores in the
> > -  SoC, the idea is to minimize the local caches at the clients and migrate to
> > -  common pool of memory. Cache memory is divided into partitions called slices
> > -  which are assigned to clients. Clients can query the slice details, activate
> > -  and deactivate them.
> > +  that can be shared by multiple clients. Clients here are different cores in
> > +  the SoC. The idea is to minimize the local caches at the clients and migrate
> > +  to a common pool of memory. Cache memory is divided into partitions called
> > +  slices which are assigned to clients. Clients can query the slice details,
> > +  activate and deactivate them.
> 
> I don't get why you are changing this. I read it and still cannot find
> the difference.
> 
> Introducing irrelevant changes only obfuscates the work you are doing
> here.
> 
> Best regards,
> Krzysztof
> 
Agreed — The description change is unnecessary.
I'll fix both in a V2 of the series once more feedback is collected.

Thank you,
Francisco.

