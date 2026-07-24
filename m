Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2BB283FCE
	for <linux-hardening@vger.kernel.org>; Fri, 24 Jul 2026 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856512; cv=pass; b=nqm5hQJ60+RKbqSD+EDJgu/HgfCYYUW9QfWNYw2So+pL+0OXjjqcDbzl83FgB94u7QDsTOl9fhVmqMRxOtzPldXgz7XP8BxgsDRnWw93xJdohZwvBIRGqAczuaqWN9luCgQktqlaTYJZprAKci/N2P4FCLup3M9QXHK+I1/p0Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856512; c=relaxed/simple;
	bh=7HDrOa1K9kHByX1pamll9b2/vr++AG+iAEaNhi4wyDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUPC4x7JZ/lwL+l46ILCY9WxO/frEaMqUYmsEOdxb8Rhnz68idHIiWHZDYaU3kjOoNzM0ua5TXN7gD6MjbJElBGUpzQbA8SPi+iBHSXaXZzL0g1gI0xPljOb+ATCgbVLyLIda6R5owrACkDFFC2IEk8EIsSxJ5bd+snOcXLekWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fTcJwwzG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CgbXGQWC; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fTcJwwzG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CgbXGQWC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLekMl1202677
	for <linux-hardening@vger.kernel.org>; Fri, 24 Jul 2026 01:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CLuIsIOJe1D2yKZ/8FWYomM57/XuNoALWUl9rATE8vg=; b=fTcJwwzG4r1UoNkN
	5xqNzTUtdfMtpwr++Gjy0AKiv9SaXiAY8tTKZA92QDg6ZDWhxLXnvzZ+4r/q57im
	rc/DGIbXsWOJrM3NdJSQxofdt0CEZ2eIB/na1OVpKmCgSGl5vnVqHTOxJjzpyQbw
	6nuisORXb+S9ubnztVdfJ5Zk2ym5lB3IoVGcFxaaZW4vvcnoGG4qCguPlU3lWLcK
	uSxFHh3f3kj2S1+/jXhJ/uCQNYB0a65V/lerUoqo1punGJD7grkjjd9/peO0T6j/
	fWKCNkWkrCjEsA+hXhV5S71W5CibA+yojUvLM9b4OMeVvShryng9xlTbz/nPXAhc
	rZqs4A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqamsfxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 24 Jul 2026 01:28:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84885a4fcabso1518437b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 23 Jul 2026 18:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784856509; cv=none;
        d=google.com; s=arc-20260327;
        b=nFTdAWbC+620dxwJolyI2JK7Fhdf+MtZWbV88Idhbu4clyKiyijtBjpxp1Emcr/4H/
         qV0lVuTsvccUghFOwDdQ8cYUe5MjbeGmQf5IaAzFxFGe4MkdCb1g2xTg37VqYgHWUzMv
         1ZMV3YayQs6fMq01M42m6kSVYMdMOCemfBLErw6iRNYilzqYrpg5cN/o/nmPnCQDq2x+
         OIhPmA7+xp2goFkx7lMQ/cV4H8sWQuFnWJMz2Q+RDlG3dikQmSAYYh5Ly+/HXuIsgjq8
         Y2qjMBrimDVJ1w4FNM7QncLuSD8fnmqlLWXeafp6WC1r1gP3NeSCP2AcQyU/sp/9OBLr
         iydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CLuIsIOJe1D2yKZ/8FWYomM57/XuNoALWUl9rATE8vg=;
        fh=yyaOurmD5BHL+oXr88MXvTqJ8dGM+qZIzcaULqFAv4s=;
        b=KfaIZNqLxd9MlYj9OfqzHw37uy7v4UksPokmHOFePvaLixuMrr1YRi33upjBZPQvD9
         eVdcRVmTEN3Vr+uItEV01HAB+/I73fJTGvb8mBvx6kFVZcNy6aUHmnIDjU8jOPXcrukc
         8rYmviGR2jC0h/9panuUHJeD0P5+0tMKXr4t4yc42zYzAO1p6jv0Za1ImsD112nZutWM
         uhvKKv0hVNfkG4bNCjoRaQ9ZrfWsI/ccrddQQTU23KgbJIwfkq3QyN4asaFgYqbXc+yG
         5bKffQZoO7jOY9/3qZASAq1tt0vjfSM1TSbGHwDuruAuY2NDQFk872y2YrITwQqXBDEx
         PnvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784856509; x=1785461309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CLuIsIOJe1D2yKZ/8FWYomM57/XuNoALWUl9rATE8vg=;
        b=CgbXGQWCfl7jtkrS27l0RFBOV4FZZznvStlV7wm8mWH+HJZKB5rIz0MjwHAeqaKxlN
         WO9V7f4Pngez3+rfMuO5mLKf4aMMuBFEt8+lu7zHIK4QxeAocpqCJTPABPLiBmjPgkrR
         +YAvO2t5f/VTlOpCuuPa6mRKrdOzBxkocs+H76+0nq6viVAVQmAsUF5HA/c6rcF2C5BW
         Nb6rLcqF/Lkg7SJE6ExSa47qpxUzKihu8w65kpABc88QaW50LWWw9Ysh34O30TGGzgVo
         fOG9aIlFAXeD2abdCIEJV6jS5kf3sW4Wk+WkPdcyyplibVa/aAf3fhE5HBBVzidkO265
         52zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784856509; x=1785461309;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLuIsIOJe1D2yKZ/8FWYomM57/XuNoALWUl9rATE8vg=;
        b=WBuXAyjI4CjfqnQhxgOZ/rJlDia3QoRoG8cXK6UpxLrsguoWhW7hfSYD/xPOgJOY79
         EiebjnXgPk5N45IzqVlg8NQYP+UT9eTPRUGudPgvzEB8ZYvj48eDg38U4I50RnfIj//A
         TDhiMGiDvtMHBO6CO9TD5YbM15B7QGlgseTzcD8e5DwAX7eCbFRiES9vM1bBqCR8hEp/
         +XnT2SCgZID4j7PhcTqWRV4iVuRpriCnoiQYF3ICIjb03UbU9qmUPhKnhakeoXHUNNJ6
         nCNKByWkSm0/ehJXms2OFSqrMkufht33KG6oovZtPC0j/W6iCEFhLM2gvyQtZ05sSHa4
         xnGA==
X-Forwarded-Encrypted: i=1; AHgh+RpdfYwPRvImZHpHTX+3PMpia71EPfTY04CR3y8fnTCWQFxT4cvVJ6gk/Nca8ensNhKvH3yKZ9Uhs688Ck/tzYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU6BqcvVXyU6aA6bqsWa4gmPBxfiU88ARRgSsB2A4bPhbA+C/f
	0i9p+qXv74MrjrKX9ndhQUPTvvgzxy60EB6a4jvwmKrs47FZL+Ho9HI+9Ty+qMHAn6man7WpQpi
	+Uzq+WdiW2wZqiCyGdPhorbRbJt5dpX4klU8awMCH70TPOPHajTKqTi6BIj/GH2831NTG+mzcIV
	xIsIRkJXc8F8+BRm43HlQH2XB9vW+YHVG5KthBcGBFRJC+zQ==
X-Gm-Gg: AR+sD10HCqlmj5taib/c6Dpc/QtSoL2TV2LieNeTk+OsXKr+ne6JP7Sx+1v3wCLnrf/
	RU99rIe7kXLAk177xn6h4VCu6GyhPeNhYMIPucrZPlblQnTaree1ela4dROPeQB81MZEZijIi6L
	hclND5Sla8gAEBixTRERZCpqgowNC9EgOPN+IAYzDVHtx2gaZAjGBggCE=
X-Received: by 2002:a05:6a21:2d46:b0:3c3:c130:3532 with SMTP id adf61e73a8af0-3c44b1ead5fmr6240032637.41.1784856508804;
        Thu, 23 Jul 2026 18:28:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d46:b0:3c3:c130:3532 with SMTP id
 adf61e73a8af0-3c44b1ead5fmr6239982637.41.1784856508257; Thu, 23 Jul 2026
 18:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618204530.work.910-kees@kernel.org> <20260618204539.824446-2-kees@kernel.org>
 <CALvbMcDwYgJNo=qeZY1m+zAutURc7rfRCaW960DDjbRAOKUZ+w@mail.gmail.com>
 <202607151337.31D0828D0@keescook> <202607151619.201AF99A@keescook>
In-Reply-To: <202607151619.201AF99A@keescook>
From: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 18:28:16 -0700
X-Gm-Features: AUfX_mwlUXJawulUsTOzU37c7STnbWn83ytJ2d5sfpnlMXjIRK3ehicOfJmxsl8
Message-ID: <CALvbMcB_pdM83JQg_F91yq2FfGWjkLynrckm6wgLdJfCDfArjQ@mail.gmail.com>
Subject: Re: [PATCH v13 2/7] kcfi: Add core Kernel Control Flow Integrity infrastructure
To: Kees Cook <kees@kernel.org>
Cc: Jeffrey Law <jefflaw@qti.qualcomm.com>, Joseph Myers <josmyers@redhat.com>,
        Richard Biener <rguenther@suse.de>, Jeff Law <jeffreyalaw@gmail.com>,
        Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
        Martin Uecker <uecker@tugraz.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        "Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
        "Constable, Scott D" <scott.d.constable@intel.com>,
        gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAxMSBTYWx0ZWRfX3FpHwpNpLwkM
 4VTMOQe5G4CdAo3swE2ioMARsAD6SJNpb9/d6M+f24ywBtQFmfFmEtY97f+cwFgvb8hiCEzUd0h
 btwj10vKfCXoNeZWHCbPuZyI5FHLVQkA5z4WzW6RimVNcj1liIOD/VEINpSfp8lP66i6aitnu1M
 inWmJlU4FSBvhl/PNkdyWEDcdsD4Adc+ZvOQghR4ejv/wfLfzOXcNAzbjs3dlMR1mHw43ZTBWJ0
 zk8e9JPpqNF5/0zmyiemscJEogjPji0vFt6YhAcoT6h4v93681N3hC1dd8+/yJ8/hxv2s3jiuo+
 LTv8AcVOpFvSkWHjQoSa9Wr0v2S/z0p/uubpXPywMS1hNklK16Bl9XkC6qqyvPrBhJS34hsBiM8
 BfD5a6GOt8nyntpNnYnOiNrCGooMxzTfvRLvM0I6NnLbl0sVkhUhvyce8k78IRFMh/Ev9CL/bNR
 W8dJFgJVdnE7Dvmzg7Q==
X-Proofpoint-GUID: 7OY7ok2pSa9tr9obPb-6mo9qM72YnzMt
X-Authority-Analysis: v=2.4 cv=DfAnbPtW c=1 sm=1 tr=0 ts=6a62bfbd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=_dWQ7dL1IJye_9a_ncEA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAxMSBTYWx0ZWRfXzOjgXMob0cFt
 T25SSqJRaZkMiEc5mdME7mQaWx7yI9d7pZuN7Kz4P3BR/f/qDRw/+Hpn82JlfrLq9Ojcq+pnzY1
 HNAFiHJM9ivo0rb4SfEXJQ4LiCCq3LM=
X-Proofpoint-ORIG-GUID: 7OY7ok2pSa9tr9obPb-6mo9qM72YnzMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240011

On Wed, Jul 15, 2026 at 4:32=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Jul 15, 2026 at 03:34:09PM -0700, Kees Cook wrote:
> > On Sat, Jun 27, 2026 at 03:57:36PM -0700, Andrea Pinski wrote:
> > > On Thu, Jun 18, 2026 at 1:45=E2=80=AFPM Kees Cook <kees@kernel.org> w=
rote:
> > > > [...]
> > > > +/* KCFI label counter, incremented by KCFI insn emission.  */
> > > > +static int kcfi_labelno =3D 0;
> > >
> > > I am not 100% sure if this needs a GTY marker or not. I suspect no
> > > because we should not have emitted assembly code yet.
> >
> > If this moves with kcfi_next_labelno into final, I think it's okay
> > without GTY?
>
> This is an int, so GC shouldn't be an issue.

GTY is used for PCH also and not just GC. This is why I question the
need for the GTY marker. A GTY marker on an int is to make sure that
it is restored from the PCH.
Maybe you can add a couple of PCH testcases to make sure it is working
correctly.


>
> > > > +      type_id =3D (uint32_t) TREE_INT_CST_LOW (value);
> > > > +    }
> > > > +  else
> > > > +    {
> > > > +      type_id =3D compute_kcfi_type_id (fn_type);
> > > > +
> > > > +      tree type_id_tree =3D build_int_cst (unsigned_type_node, typ=
e_id);
> > > > +      tree attr =3D build_tree_list (kcfi_type_id_attr, type_id_tr=
ee);
> > > > +
> > > > +      TYPE_ATTRIBUTES (fn_type) =3D chainon (TYPE_ATTRIBUTES (fn_t=
ype), attr);
> > > > +    }
> > >
> > > Instead of an attribute there must be a better way of doing this.
> > > Maybe a hashset instead.
> >
> > Perhaps? I will go examine this vs LTO, etc.
>
> Tracking this with lifetime tied to the fndecl is going to be more pain
> from what I can find. The attribute is stable and doesn't cause problems
> for LTO: I've tested with 2 TUs, and this all appears to happen
> post-merge? Anyway, if there is something I've missed here, I'm happy to
> find a new solution, but I can't induce any problems so far.

So maybe we add a field for FUNCTION_TYPE for this instead of an
attribute. But that requires extra code for streaming the LTO and
such. But it will reduce the overall overhead in general.

>
> > > > [...]
> > > > +  /* Emit .type directive.  */
> > > > +  ASM_OUTPUT_TYPE_DIRECTIVE (asm_file, cfi_symbol_name.c_str (), "=
function");
> > > > +  ASM_OUTPUT_LABEL (asm_file, cfi_symbol_name.c_str ());
> > > > +
> > > > +  /* Emit any needed alignment padding NOPs using target's NOP tem=
plate.  */
> > > > +  for (int i =3D 0; i < kcfi_alignment_padding_nops; i++)
> > > > +    output_asm_insn (kcfi_nop, NULL);
> > > I think you need to calculate kcfi_nop each time you call this
> > > function. Instead of caching it. For GC reasons.
> >
> > Uh, do I have to? This seems wasteful: the nop is generated frequently.
> > Should kcfi_nop gain GTY instead? I will take a closer look at this.
>
> So, while I could go full GTY, I opted for xstrdup instead. I've
> rearranged things here now, and indeed, LTO created some issues.
> Upstream Linux doesn't have GCC LTO support (there are trees but no one
> has been pushing for it), so I hadn't tested this area at all. I've
> added some limited LTO testing now.

I am less worried about LTO and more worried about PCH when it comes
GTY markers really.


>
> -Kees
>
> --
> Kees Cook
