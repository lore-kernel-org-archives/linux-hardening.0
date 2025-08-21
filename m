Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B762DBF5E
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793518; cv=none; b=F9D5aaaVheKqYHy/Uyl2so2F3p6GWs249EagYzI4yEpbxDvERWTT57tpcGI3VC8IPjOEOgJul17RYyL5MlkmtPOQ1rPO3yCBcm0UYGinq5DlaAsgsOu3HeSCbOIpnyjgy7+qKQfpXzJ+QV+Ypm0iKyuKHxtcmrK+BaBdDXQjfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793518; c=relaxed/simple;
	bh=t+WjTMyeZV1cA4ryhfe1pzuhSAuOPnagSMgKY1Id2J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQ2b8QW7S/oIFcX1zuan95j2NN4+K+MZSmglL0xJFwQwUd0OBvbj5AjFj/ncCWjwDf/PNGtBBmrqwQITaW4mGHgCFwrw8lXcBEIx1qc3EqSnRybJxfa/AkAMCcje16UpBBqwEi+Uge5Rg2NInMAw8TaZJ4JgFVwotwpnRM+k3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VJZbLFWa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VJZbLFWa"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bBRi003703
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 16:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lSpWVZnxMXoC5Gefmb/JGgQW1/9OzwKbHcGAhVY9vLk=; b=VJZbLFWap52SnKGm
	wX2BUM6DLAdvi+GowSDEnNI9za6oIgaYHnmzS/eA+ZY26DI5fy17YsmfQCpBAgz1
	bmU/kYamfrzc05IwBmJTZQL81Fac2xRj85x7tfvklxR5sBAu9iDBLm+TlIJFodSX
	h9EVc6+2HZ1MyImazIASz6GWxsBT/3hCHxKqn55rqVDGdgNDHhbG4wmc0r2eSA9j
	CinpdCmFEhNSloJ4ZJ2e/2gVrIcwbsSpj1XUyTZIpp2baCHZ/5PD1+GA1xRw2Jly
	RoChUEcvt+ovgMPcRMEcrDN9NyaM/h2KM1dxL07Rx2W7WfOGZNb4Eent97lgUEi8
	prMCQA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdky82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 16:25:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-245fd2b644eso21041915ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 09:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793512; x=1756398312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSpWVZnxMXoC5Gefmb/JGgQW1/9OzwKbHcGAhVY9vLk=;
        b=vuwiA3i+tcwO58Wq1zVYRoGTdY4KUyb4iSDfF+Cg2Dt1joKgiciX9+gzdIy99V53oj
         15FmOEVyg6OKaqigunQkgMtq2C84y482cNBKDfyk5OhrlLfKTFQr/UCUt7oQSbCIFM7J
         /YnCqNsEhM76Mes3BiAv5zNJa46UjOG8lc9ixaj/aWl66dNDKpohdWLxCVtxhbowbgIg
         an+xXR1Zp42dYb+C8An8zn8h41MQV+t5YhfLDe4jR4mxdPq4qn1aX2B3LPc5CqgHe3kp
         X2SmeFsLGvCcQk+uqPYKFlFIpplxNijZ92MdpS2LO3xf3jwhSyYvQO5voJaEqJE9NzfE
         Lg4w==
X-Forwarded-Encrypted: i=1; AJvYcCWllf7XUwSNEihsAZsS1hiocJE0IRabMfec/iiVeH4tK8Ss6fpdPI1iSxu6vZprV0btla5TzHVMfSJByC1xXPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuy7Bsly1zy7l1bZNGSe/Wyx60tJh0+2tR8FZ/+yeu8i6TUd2s
	K2HLlzHNvjOI01tR/NKqB0QuC8egAJrV/tYHBV7pvcx90vglDC/HQV0cHZULACELy/dKELv3QAl
	QUPXD2pi++4oDa4tH03K2SIFhRBqFwUv4mnu1jv/8U82Jf77IlOhJyQinnBxCeIG/1eiFDAYebS
	ltU1QoHYN3P3709uYhsXqTYRH0fEsf2lNIRjUdSpWXdt7+hQ==
X-Gm-Gg: ASbGncuGGEyUPvLduB9H03GHdZHyVby/25TqIsN00S1In9KOCnCRBUKbDmoEvA8X0b0
	hrsZLyGEVCq9MIrRiM63xQbgD7I3KL0hwdRLlfiHOuSZCVdILSicvfb4f44yzzUYYtkgL4xnC8+
	cwJ8yaXKyaUxUZdX9OUxM=
X-Received: by 2002:a17:902:e841:b0:246:255a:1915 with SMTP id d9443c01a7336-246255a1a16mr13455535ad.27.1755793512228;
        Thu, 21 Aug 2025 09:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFNojIzgFL39qSZy1ft2aXfPVvVjG4soNKHxLuVwbEDbi6DM1vxvpPhYH1dv2+065Yh83nrn/eJhaV9Iz9nvw=
X-Received: by 2002:a17:902:e841:b0:246:255a:1915 with SMTP id
 d9443c01a7336-246255a1a16mr13455125ad.27.1755793511568; Thu, 21 Aug 2025
 09:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821064202.work.893-kees@kernel.org> <20250821072708.3109244-2-kees@kernel.org>
 <CALvbMcAPV1eB6nocPAS=qR8SCiQyU43v911R8S7Ah_=G7yK-+g@mail.gmail.com> <202508210841.8BE6E3C117@keescook>
In-Reply-To: <202508210841.8BE6E3C117@keescook>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 09:24:59 -0700
X-Gm-Features: Ac12FXywL4DVmDY_DYNbKaBy8dUkpCSDQR88DPpv2zR6uC_s-mDzkxoi0geydN4
Message-ID: <CALvbMcAyh0cvx-465sBh-g9xX_B2nQ-7+5gmWEJ3-uG19faOig@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] mangle: Introduce C typeinfo mangling API
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
        Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
        Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a7486c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=VwQbUJbxAAAA:8 a=AABx8ZXEtySrmDuHCdkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ILveqw8Q9aZYDofqkG4P4sq7GejHacxd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfXwa1dbK6hcH1e
 RT/WTm7viwJ8G3+ctngNSrY8Wd7MzqmERuQN520xKltqCRqFKe8/jD2PFZxvEhgdDT/ff8smpnm
 1BKMYVaCjZgkc1LV2JrK0LVKDFK3QTNsB6dbosCRAOLRFXOy/IJM+1o9eFR5Me73iK7Qwuw4QRE
 Re8Fay7wBrP08O/41LtqJ6HEsJKN4FFQ3oUD8nA0V3OoP4wF2ejMe8fHzKForlnZ5Fg5d8/To4c
 EmjZ/duuIwOvjmi14+H/byaQuu+ebvcTWRc4vpRS9yApFLh2xBp8kbNVA6POVXnB9ehv5y8UV2b
 XMfmHAEfbYW5EA0ZBPkShrSxF1WNlUrVdq+kJj5YyB6g5IRXX5if8LvgkoqGCm0uZ0BIXBjkzRN
 nTkdfAiHT29gmj0CLe2nCR8z9CIxhA==
X-Proofpoint-ORIG-GUID: ILveqw8Q9aZYDofqkG4P4sq7GejHacxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

On Thu, Aug 21, 2025 at 9:16=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Aug 21, 2025 at 12:59:06AM -0700, Andrew Pinski wrote:
> > On Thu, Aug 21, 2025 at 12:41=E2=80=AFAM Kees Cook <kees@kernel.org> wr=
ote:
> >
> > > To support the KCFI type-id which needs to convert unique function
> > > prototypes into unique 32-bit values, add a subset of the Itanium C++
> > > mangling ABI for C typeinfo of function prototypes. This gets us to t=
he
> > > first step: a string representation of the function prototype.
> > >
> >
> > Can you explain why this is needed? Also it seems like the code is very
>
> As you suggest later, this could just twiddle hash bits instead of
> building up a string, but I left this as a C mangler in case it might
> be useful in the future, and for debugging. Trying to figure out why
> certain prototypes got mismatched was super frustrating, and looking at
> a hash value was pretty meaningless. :)
>
> > sensitive to buffer overflows. Especially the way it is currently writt=
en.
> > The C++ front-end version uses obstack_grow to overcome the buffer over=
flow
> > issue.
>
> Oh nice, yes, obstack looks perfect for this. (Or as you suggest below,
> std::string).
>
> If keeping the mangling string output is unwanted, maybe I could use
> obstack when the dumpfile is active and report the string+hash at the
> end of mangling, but make the actual output be the hash value?
>
> > > +    case BOOLEAN_TYPE:
> > > +      **p =3D 'b';
> > > +      (*p)++;
> > >
> >
> > I am not 100% sure this is always correct. because there could be a boo=
lean
> > type with a precision non 1.
>
> AIUI, the non-1 case isn't possible on the C end of things and since
> this is strictly for C type representation, it's good as-is. But maybe
> I'm missing something?
>
> > > +      else
> > > +       {
> > > +         /* Fallback for other real types.  */
> > > +         *p +=3D snprintf (*p, end - *p, "f%d", TYPE_PRECISION (type=
));
> > > +       }
> > > +      break;
> > >
> >
> > You definitely miss NULLPTR_TYPE.
>
> Isn't nullptr C++-only? I don't think I can create a C type that ends up
> getting internally mapped to NULLPTR_TYPE.

NO, it is part of C23.
`typeof(nullptr)` in C23 program will have a NULLPTR_TYPE.
I just posted some fixes for the C front-end in the area of
NULLPTR_TYPE which is why I know it exists.

>
> > > +
> > > +    default:
> > > +      /* Unknown builtin type - this should never happen in a well-f=
ormed
> > > C program.  */
> > > +      error ("mangle: Unknown builtin type with %<TREE_CODE%> %d",
> > > TREE_CODE (type));
> > > +      error ("mangle: %<TYPE_MODE%> =3D %d, %<TYPE_PRECISION%> =3D %=
d",
> > > TYPE_MODE (type), TYPE_PRECISION (type));
> > > +      error ("mangle: Please report this as a bug with the above
> > > diagnostic information");
> > > +      gcc_unreachable ();
> > >
> >
> > This is wrong way of doing this.
> > It should be a sorry or a fatal_error instead. Maybe with an inform
> > beforehand.
> > You might also want to use get_tree_code_name, GET_MODE_NAME instead of
> > printing out a number because the number tells nothing.
> > Maybe even use print_tree or print_generic_expr to print out the tree
> > instead of manually printing it.
>
> Ah, perfect; thanks!
>
> > > +    case ARRAY_TYPE:
> > > +      /* Array type: 'A' + size + '_' + element type (simplified).  =
*/
> > > +      **p =3D 'A';
> > > +      (*p)++;
> > > +      if (TYPE_DOMAIN (type) && TYPE_MAX_VALUE (TYPE_DOMAIN (type)))
> > > +       {
> > > +         HOST_WIDE_INT size =3D tree_to_shwi (TYPE_MAX_VALUE (TYPE_D=
OMAIN
> > > (type))) + 1;
> > >
> >
> > No check to make sure array type is not a VLA. So this will ICE.
>
> Oops, yes. Thanks!
>
> > > +  else if (TREE_CODE (fntype_or_fndecl) =3D=3D FUNCTION_DECL)
> > > +    {
> > > +      tree fndecl =3D fntype_or_fndecl;
> > > +      tree base_fntype =3D TREE_TYPE (fndecl);
> > > +
> > > +      /* For FUNCTION_DECL, build a synthetic function type using
> > > DECL_ARGUMENTS
> > > +        if available to preserve typedef information.  */
> > >
> >
> > Why do the building? Seems like you could just do that work here. Also
> > doesn't FUNCTION_DECL's type have exactly what you need?
>
> I need the function prototype in three places:
>
> - address-taken extern functions
> - function preambles
> - indirect call sites
>
> At indirect call sites (during the early GIMPLE pass), I had a
> FUNCTION_TYPE available that still had the full typedef information,
> and I could use it fine. For the other two, it's later on and the
> TREE_TYPE(fndecl)'s FUNCTION_TYPE had lost the typedef information (which
> I need to be able to examine in cases where the typedef name was needed
> for the mangling vs looking at the underlying types).

What typedef information do you need that is missing? struct names? or
something different?

So from the looks of it there is a big issue with attack vector where
you have 2 different structs with the same name. Seems like the hash
should have included the fields of the struct instead of just a
mangled name of the struct.  Can we break the hash for GCC's KFCI from
clang to include this extra hashing info? and maybe even fix up clang
later on?

Thanks,
Andrew Pinski

>
> > > +      tree parm =3D DECL_ARGUMENTS (fndecl);
> > > +      if (parm)
> > > +       {
> > > +         /* Build parameter type list from DECL_ARGUMENTS.  */
> > > +         tree param_list =3D NULL_TREE;
> > > +         tree *param_tail =3D &param_list;
> > > +
> > > +         for (; parm; parm =3D DECL_CHAIN (parm))
> > > +           {
> > > +             tree parm_type =3D TREE_TYPE (parm);
> > > +             *param_tail =3D tree_cons (NULL_TREE, parm_type, NULL_T=
REE);
> > > +             param_tail =3D &TREE_CHAIN (*param_tail);
> > > +           }
> > > +
> > > +         /* Add void_type_node sentinel if the function takes no
> > > parameters.  */
> > > +         if (!param_list)
> > > +           param_list =3D tree_cons (NULL_TREE, void_type_node, NULL=
_TREE);
> > > +
> > > +         /* Build synthetic function type with preserved parameter
> > > types.  */
> > > +         fntype =3D build_function_type (TREE_TYPE (base_fntype),
> > > param_list);
> > > +       }
> > > +      else
> > > +       {
> > > +         /* No DECL_ARGUMENTS - use the standard function type.  */
> > > +         fntype =3D base_fntype;
> > > +       }
> > > +    }
> > > +  else
> > > +    {
> > > +      /* Must only be called with FUNCTION_DECL or FUNCTION_TYPE.  *=
/
> > > +      gcc_unreachable ();
> > > +    }
>
> Thanks for looking through all this!
>
> -Kees
>
> --
> Kees Cook
