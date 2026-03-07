Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C131E833
	for <linux-hardening@vger.kernel.org>; Sat,  7 Mar 2026 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772912344; cv=pass; b=jDOY6B6u+0hcDFk0rgR0paUoNlZPeMp3CG7KKZC0P5m4nvzJTGsU9bSaTqC8DVeL5p2M4VLbP/n2S+wmVB0WYz+1f5xg9YXZo3LJ6MB0C/r77sIW0URDFwTXUb3BHg3dgaBz7RQLPa3pydMbS8likBSui9vAC4IVn3R4BHWZLbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772912344; c=relaxed/simple;
	bh=rhZlTgbYYLgt9Uupv+t7E6wLa4NIJMEx9/DyA8Ujzt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0xnYsw0sDGSVU69bYvR+0zA+GIRllN4+MdKP69TML3g7CSjdgqsk0OXlY2hHCEk6Ux0CoPYEILLFApLG4elutu26Qwc4LmLBzaGNRloEsiTrYCk8wE7y7LM8NYwCxK2Z/lVYQWxFE/yqV+TxWbr0L9t+iTqBaYZ3ycR5GhTfwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lj+TqNTy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hsMSMr1i; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lj+TqNTy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hsMSMr1i"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 627CB6oh241850
	for <linux-hardening@vger.kernel.org>; Sat, 7 Mar 2026 19:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OzZyyDusjfRV27sdI+FkHL20sIdrZsjAAdQhTvQn0Ig=; b=lj+TqNTy2rKxQnPD
	Le/cn4DbyUT4BjvADe3eLckFrd4U7utuGIi3RwVKoG2HP72PDyGMJrpmY1yvMrAy
	8pUopn4gSJhXgQu5x2NUqS7vogh1YEr5PDk4rkfYvoAeP9NL1w42EFewXXonMcA2
	lFFnPeZWH0cqmr2J/C2yHyd+xIkMvBEXxJlZBb9gG/kYIG++iODzW3+AacvcE1El
	p28H6FJerc7cGf359Gn6g2sqp0qj/s9hubMray/hJSKvlXY3rDDN6a/VS2uSEyXv
	UPkerJ2hI7zIUDbgL+btWlnYh5PHVAAYICpyQvUR4F84CO3qOMrNL+19p2J1RnJw
	vtec3g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crc3v9b5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 07 Mar 2026 19:39:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2be0575e290so5947493eec.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Mar 2026 11:39:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772912340; cv=none;
        d=google.com; s=arc-20240605;
        b=HFIKjjmJBVVNTi55Id0nwh8BqYzAjB7Vcj9gRx3pr0frLGjpSiDeqFyK1biH1bk6pr
         thoo1uwl2BJ/xKDlchiyRO0+xCuTPyEZWJs+TdLApT1NJnfy98VHhcTSYp1YSRkxEWHE
         WPornthRMiWxkFk86cyAOUBtCayFbHWMTCUFPFx/XrSyLPk98QPngg39Q3c74kjs2xqh
         0kbQPhiPcj1PTnFhMrtlLMMKM50/ex0Y7/EpBqGyp5Ticds1vsMkhRcq29GAswylR3yk
         roruERc8cFkW5Aa9fwOzsppzeHXne2+8GtgV/B6H+PjPCNigWJF8Dqcb3gysg0Tf0i6h
         qdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OzZyyDusjfRV27sdI+FkHL20sIdrZsjAAdQhTvQn0Ig=;
        fh=hX5fNh2luEoQ7WZdgiCByy7Q5y9D3NTdVe4bPSrt8BQ=;
        b=BTHItqqDphGbQi0AUZ/8IWszYEm+w4C4ylBA/FqcCFnS4x4kILQeC6vQzwbbMleowv
         Pey8H6tik9YhJEYWxoWS+HFYgIu60zSvvuWboj7pBffycoiTWyh5jGzlHboWyFr0ng9m
         sS2E/YW+Q4s2OKOZhVa9IGI0xV1h2RZiYyYrIyWTuveOniK92JFq2lPhwXuDQBPRQZwJ
         kCpt6l5JLOzmhEXFXA10w31MxS99X+u756k8Z5LpYWX78vlkCXpRHMSGYd9VkGoN0DWG
         SD7UBpOSkXaOiAWdKw0TGPMIH2naQhu2EXSTbc9X3iP0VVnZWKWLvc++yF34ue4WCvtn
         qolQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772912340; x=1773517140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzZyyDusjfRV27sdI+FkHL20sIdrZsjAAdQhTvQn0Ig=;
        b=hsMSMr1iXa3Fj7oVd6/y89yH1SqLJ0OIzwj9Y/7ypQGr7fqwXi1LrSuB2mDxY7KpF+
         P53Ob1zPH1lMWaZJwkxzzFaSEP/FduYqMFPK/7/c5/ycCgW49XN7HaSTOpxg1ycK5KBq
         edFiXZ6Yl23uOw73+t37EQul2/AbwSAp1yRJEdNEffVLjBSn0HwP4HtoNE3LBqAaHOoq
         VU78OxH0yX5mrPsRSwhkbz68EFRsDdvG7bg5fq6GXamnIPRf7yXzL1F1/mgSVLhxzfpy
         PLbvJAJDYR/YtySoWBgYhSoQqzdI8AlTncD338nnognWOyIu6ZJREkKDvNFm47SmhHGt
         66Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772912340; x=1773517140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OzZyyDusjfRV27sdI+FkHL20sIdrZsjAAdQhTvQn0Ig=;
        b=NlWMA5Ph72vXW0AnTRww786nvQ3iTyPkJWFTdzh6QYRKs07CxdREeQKeNAZ8R4dg9N
         DtnKcsNpIrz/p0B+4/7OTvJeKEET6FCwNB6JUoiUO4pKQqoj9U9B3KfYiS7CuLCkvKY1
         NHHDQP6Z3Qh5R0lJb0ViUhgYDfJG6pdY+sMse1MSfai+SimzjyOR9n7Ry6B8KJtJEWHG
         UDJ8kxjWhEA8hn0Z2LqrbK0FXXRdaQbgqe9SG1R1alJ3m0ePR3jct1m3mo39LXK14IYm
         AQKGv7w4hQYSCMTloHdq4v2tlJv2UhjMnVaGBKxCy87mE0fLSaHI6G92T+vX4gHZu77C
         8CQw==
X-Forwarded-Encrypted: i=1; AJvYcCWQKGjr7cNFiAoNmj0C+eLodn3l+2wkk293ezx/SdlMZ6adIJha5okg+FiSf+IlaOmKuZn2eDYmoVyxvioyp+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRGw2gu9w5ePaa2l7dqWo0zxsoLDwOo3FtEFsvnnxD94cX4+f
	LYiEUb2yeqEs73ezgGcAEEIhikvJ+XTRh4mdc0CqijFLiARwX4XPsOUY3bonUfprLkIxplylHFA
	BLUI8gIZi6J4LTqIigCx8prf4a7OeCxb7XWZTbsD0FjmYnUR6dST3sYap7k+QuGxPePqJqXfjYK
	iaBTTmE+9wsYTu4MD2RSN0AY5FN/2IqlZ5RxpuAbDPkR+9pQ==
X-Gm-Gg: ATEYQzwXXNw+30Y16oGp2qXF338gWC+jPrhpwKeSZFRId806vjcBUVcYLRoGSBbiwQH
	SK3afNYJ5ipV163YY8i5uwjk40jDJQ0XSQwB0zIiM2+ZtlTWUyYbZRnv1MbwytzbIWF56TLQp7/
	WLydh0M2anHEAlSoeP4FHEFKRkJb8CP6NXv0DxOryqsWrI1QrTr1Cut/GXr+3J2Dxup6w0guezu
	Ipk
X-Received: by 2002:a05:7301:4b03:b0:2b6:af85:dd2d with SMTP id 5a478bee46e88-2be4e08b2a4mr2321259eec.32.1772912340234;
        Sat, 07 Mar 2026 11:39:00 -0800 (PST)
X-Received: by 2002:a05:7301:4b03:b0:2b6:af85:dd2d with SMTP id
 5a478bee46e88-2be4e08b2a4mr2321252eec.32.1772912339607; Sat, 07 Mar 2026
 11:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb90ec7f5d724213b164e9f849675907@h-partners.com>
In-Reply-To: <cb90ec7f5d724213b164e9f849675907@h-partners.com>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Sat, 7 Mar 2026 11:38:48 -0800
X-Gm-Features: AaiRm50OQJAl7nsoOaAhYvLRwuCU3RX8XQfUXS8xQQFhRssd78WHjBXthH5wuDE
Message-ID: <CALvbMcB_RwNuWwN21=UM8xbh57gBoS73LSU_XBSq4iYd5XAVDA@mail.gmail.com>
Subject: Re: [PATCH v4] Fix sanitizer attribute infrastructure to use standard
 TREE_LIST format [PR113264]
To: "hanwei (K)" <hanwei62@h-partners.com>
Cc: Indu Bhagat <indu.bhagat@oracle.com>,
        Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>,
        Qing Zhao <qing.zhao@oracle.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: gFlizLmpq9ZyrCXro1p6sAUbP6nykLyY
X-Proofpoint-GUID: gFlizLmpq9ZyrCXro1p6sAUbP6nykLyY
X-Authority-Analysis: v=2.4 cv=OOQqHCaB c=1 sm=1 tr=0 ts=69ac7ed5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=CCpqsmhAAAAA:8 a=yPCof4ZbAAAA:8 a=u7uoXELoAAAA:8
 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=xduvcD8Vs6fBkbsrRisA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=ul9cdbp4aOFLsgKbc677:22
 a=07tN73Fy-TQQJT60VmHH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE4NiBTYWx0ZWRfX4AVjH4cWZMDb
 mIuzCN/uEPBsc4qmEDPw2mkNLBefNOuEhAMbULmpxOiUD44+1TwKSUZmqNDksZgXBAZHqNfHH78
 g55pNFvULThfYg6OdmRVsIs4POoBb6g7H8eVMkg5HRIudxT7dcOgi755UVrEx1uIC0Xfpumr7o1
 ElHDkkp3oEF7tikdiDzXdLkZ0Lt11vOhvjnsN0m8eCkuwTbfBNi79R9GMno2ISAlProca2QqSUu
 xmf+vl5bstcMucvPW9AZb+poDmlZFbkcVcJ51ob2MZT5wI0t9zYXZwwC41QAN2ebTSv7BWuouya
 90mEShMNJh+dqi3H0APjABIfI5srxciDMSooX5n3+li1KSl9HOO7khw2v2zBc5Jh9ZWkffIde8E
 DW6Vqw1vUfUE01j7OarPVC8yeM1i1PAhmwjaLA045TOS5p1kR9D9lcEZMB8+XZIGLvrne4Rmor8
 n+zwT8h1QWJxjpxdAYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603070186

On Fri, Feb 27, 2026 at 5:22=E2=80=AFPM hanwei (K) <hanwei62@h-partners.com=
> wrote:
>
>
>
> Ping...

Can you submit a full new patch rather than just a patch on top of Kees pat=
ch?
Please use Co-authored-by: too.

Thanks,
Andrew

>
>
>
> > On Wed, Feb 25, 2026 at 12:28=E2=80=AFAM hstk30 <hanwei62@huawei.com> w=
rote:
>
> > > On Mon, Feb 9, 2026 at 12:28=E2=80=AFAM Andrew Pinski <andrew.pinski@=
oss.qualcomm.com> wrote:
>
> > > >
>
> > > > On Thu, Sep 4, 2025 at 10:43=E2=80=AFAM Kees Cook <kees@kernel.org>=
 wrote:
>
> > > > >
>
> > > > > The __attribute__((__copy__)) functionality was crashing when
>
> > > > > copying sanitizer-related attributes because these attributes
>
> > > > > violated the standard GCC attribute infrastructure by storing
>
> > > > > INTEGER_CST values directly instead of wrapping them in TREE_LIST=
 like all other attributes.
>
> > > > >
>
> > > > > Wrap sanitizer attributes INTEGER_CST values in TREE_LIST structu=
res
>
> > > > > to follow the same pattern as other attributes. This eliminates t=
he
>
> > > > > copy_list() crashes when copying sanitizer attributes:
>
> > > > >
>
> > > > > test.c:4:1: internal compiler error: tree check: expected tree th=
at contains =E2=80=98common=E2=80=99 structure, have =E2=80=98integer_cst=
=E2=80=99 in copy_list, at tree.cc:1427
>
> > > > >     4 | __attribute__((__copy__(__tanh)));
>
> > > > >       | ^~~~~~~~~~~~~
>
> > > > > 0x859d06 tree_contains_struct_check_failed(tree_node const*, tree=
_node_structure_enum, char const*, int, char const*)
>
> > > > >         ../../gcc/gcc/tree.cc:9126
>
> > > > > 0x860f78 contains_struct_check(tree_node*, tree_node_structure_en=
um, char const*, int, char const*)
>
> > > > >         ../../gcc/gcc/tree.h:3748
>
> > > > > 0x860f78 copy_list(tree_node*)
>
> > > > >         ../../gcc/gcc/tree.cc:1427
>
> > > > > 0xa755a5 handle_copy_attribute
>
> > > > >         ../../gcc/gcc/c-family/c-attribs.cc:3077
>
> > > >
>
> > > >
>
> > > > I am not a fan of the wrapping because it increases the memory usag=
e
>
> > > > slightly but it is required since the rest of the attributes code
>
> > > > requires TREE_LIST here.
>
> > > >
>
> > > > So Ok.  I will do final testing either Monday or Tuesday and push i=
t after that.
>
> > >
>
> > > So this causes some ICEs in the testsuite:
>
> > > FAIL: c-c++-common/asan/inline-kernel.c   -O0  (internal compiler
>
> > > error: in tree_to_sanitize_code_type, at tree.cc:6704)
>
> > >
>
> > > 0xa4376b fancy_abort(char const*, int, char const*)
>
> > >         /home/apinski/src/upstream-gcc-new/gcc/gcc/diagnostics/contex=
t.cc:1812
>
> > > 0x92f581 tree_to_sanitize_code_type(tree_node const*)
>
> > >         /home/apinski/src/upstream-gcc-new/gcc/gcc/tree.cc:6704
>
> > > 0x92f581 tree_to_sanitize_code_type(tree_node const*)
>
> > >         /home/apinski/src/upstream-gcc-new/gcc/gcc/tree.cc:6702
>
> > > 0x128bea2 print_no_sanitize_attr_value
>
> > >         /home/apinski/src/upstream-gcc-new/gcc/gcc/tree-cfg.cc:8223
>
> > > 0x128bea2 dump_function_to_file(tree_node*, _IO_FILE*, dump_flag)
>
> > >         /home/apinski/src/upstream-gcc-new/gcc/gcc/tree-cfg.cc:8276
>
> > >
>
> > >
>
> > > Looks like you forgot to update dump_function_to_file too.
>
> > > Can you double check all of the locations that use tree_to_sanitize_c=
ode_type to make sure they all have been fixed?
>
> >
>
> > Fix this fail by below patch:
>
> >
>
> > diff --git a/gcc/tree-cfg.cc b/gcc/tree-cfg.cc
>
> > index 66ea54f8b85..808b8000603 100644
>
> > --- a/gcc/tree-cfg.cc
>
> > +++ b/gcc/tree-cfg.cc
>
> > @@ -8220,7 +8220,10 @@ dump_default_def (FILE *file, tree def, int spc,=
 dump_flags_t flags)
>
> >  static void
>
> >  print_no_sanitize_attr_value (FILE *file, tree value)
>
> >  {
>
> > -  sanitize_code_type flags =3D tree_to_sanitize_code_type (value);
>
> > +  /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
>
> > +  gcc_assert (TREE_CODE (value) =3D=3D TREE_LIST);
>
> > +  sanitize_code_type flags =3D tree_to_sanitize_code_type (TREE_VALUE =
(value));
>
> > +
>
> >    bool first =3D true;
>
> >    for (int i =3D 0; sanitizer_opts[i].name !=3D NULL; ++i)
>
> >      {
>
> >
>
> >
>
> > I have checked the patch which first introduces the tree_to_sanitize_co=
de_type
>
> > (https://inbox.sourceware.org/gcc-patches/20250813104306.20804-3-claudi=
u.zissulescu-ianculescu@oracle.com/)
>
> >
>
> >
>
> > >
>
> > > Thanks,
>
> > > Andrew
>
> > >
>
> > > >
>
> > > > Thanks,
>
> > > > Andrew
