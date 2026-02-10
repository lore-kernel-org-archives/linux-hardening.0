Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6C629D29D
	for <linux-hardening@vger.kernel.org>; Tue, 10 Feb 2026 02:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770690905; cv=pass; b=A35Qc69MtN6M/BRqo7UygjKtIuCiX5ObsQMKwBDKCW34EgHBl3yQzdFE+M4MqWcuPQdfytgaNpW4kZ/GV01hbS6PAjX81sbrowyj2cioQaIAKwDf1kogBMAICYsdgJABl3sBH2LHGG8HBPar0bgkSzIlx4KeAPRwDrE3/VOcwfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770690905; c=relaxed/simple;
	bh=f2o2ezYq0OUZtQoHkYPzhYCdPLi5ginVCzHUJsRJs2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3z/St8fqhJV0RLy0xT+AGEMJOWhdHlbZ415BtR+tX4+vpBXZt4a56uBpBKGzE6ylWtRW3Vv5cJKCaZ7UuvkGcJ57/gmE48tiKE/rcgeSygw02FlhVfhwc04ji9s7z91TGqEYL73SkbLICAnXD6qQDrEcaTXYJ2e1AM4aT652eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HXHzlr1T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aNMpycEP; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HXHzlr1T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aNMpycEP"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619Gq8gE1172379
	for <linux-hardening@vger.kernel.org>; Tue, 10 Feb 2026 02:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	15VHGfJ9b5OHzpDTbKacn0MiEPsYQpbqtd6P5HXW6cw=; b=HXHzlr1T/SEnabFV
	jFlGqRzNQ8VrChPnWIyPDNkav0dvyOerBZmyLyqP7nQ7qplRyhzGFHklI6oQtGs1
	M5BeDAXpL846jqPDZDqP44LvHHwbarwJOW89bseniAqc4Rj+g085LG71ih4hMp2e
	+rakDJMnU5LcdYW6YGXDL8cA/aUTLiHW3T5uo8srSNv8NVClF6s8T3Hsy2BQiBzA
	vIDB+5E/WoMzi92Q4R/L7qwaiIat+ClQWCnIPDmLopQ3of+QXC46i2Y/vVXbj9YF
	KevvAJAzb4xqPvysRxMyCupJlTmA4JBAOMk4O4bGMCshd3lxwZktBuMDwy3okJNj
	4qd3Ig==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7kftsq8a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 10 Feb 2026 02:35:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so233240eec.0
        for <linux-hardening@vger.kernel.org>; Mon, 09 Feb 2026 18:35:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770690902; cv=none;
        d=google.com; s=arc-20240605;
        b=jDJqswZG/i8yRehzx7hqo9Vw66WRekLpSJNti74FOGka4K5jVOZqMNOawz0MIcFHCY
         1CK2Z7EPQJ/MFvgw7eF6z8BnXTjLgT8tIBZ8yBxTgyi5Da0yOVDcpI63Nd9Zgq1GThlr
         QE2lHAiSsaoiwaM9Grtf0L+9qcgrznS8NCwwJHImK7/XqGNdyNaTIt68MxfQLYZmhwU3
         fgAQc7xRic8RC7PVhji9iLyc8ZG5l7/riC6XnhmZlSs1dXbVOigHTt5QRS5qbz3ApEuw
         Rfgy0DFTSEkfnfnFQaXmXACj6+zsjnWWIMTv+g834Nlkn1EwRpQMHK/RjsQUZdMJcISk
         2XdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=15VHGfJ9b5OHzpDTbKacn0MiEPsYQpbqtd6P5HXW6cw=;
        fh=2BamvAZbyfblbwllFmdqUsovcdKRVmQycw8vtpGjhNA=;
        b=PtxAVucQyr95uy0jKOKFXJeJqKZ3zuevUGfRN3GCITGOh0nhJb8ks89WiCsBrfMQPW
         Rt9pIX2TdEnQJA75NByYEmt8y9VgeGoE1otvfRbQ68TbCVDPQQZo1TvckyvyG+CcjtJU
         +9ONAQ0Phg62eR4ZLCHYRJ4epTj1G8wJcCepFyi5ZKMkAgvuSG0ryMHmoWvaX/s7wQUl
         fKPCWgtML5PUsXJusipllHsW67fXaEZmT1HEFMcLKYaE4h+r9kQLQ+d5gIwuv5J9xEvE
         EeUOsH+nJxiCFDzaZPSzvfLgrRI7jGzQOMw+uoOQ/YM0T9u01Zm5rzrppYkIfPbLgAe+
         7W+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770690902; x=1771295702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15VHGfJ9b5OHzpDTbKacn0MiEPsYQpbqtd6P5HXW6cw=;
        b=aNMpycEPun9lDowI1NXIRl6M87FRRuZRM09meaUp92r205GOz0PUvEFWSuyrOfQTlo
         TawbqyfqdG+hDOTTjVw0Nn9EYGRaFE7jUNxOjK8/ICMkduxJ+H54q6KjlO0pjOM7Cr1u
         bfdQaFRnKuqUBBQhpZiP/IYAvamPhtZGCP33sL75ELTwADjad48dBHWK6s+vo+NMUp1w
         CVGQfMihrxCwPPj5w/+EnntxDHWdWnbXo59D+lRCTL377r4RXDFMxJDZpAfPiV5/m7Tz
         y5qrVKVceT3MsG0WCEO5O45uRetz8y/e7PGqAhyAphw2lrReC0rU0LK+zqWYhs0dwEAQ
         8+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770690902; x=1771295702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=15VHGfJ9b5OHzpDTbKacn0MiEPsYQpbqtd6P5HXW6cw=;
        b=aA983ZSdGMDAdx4o0Jm6xuapgAzy/1qNSuzytC/zua3KqbsyDulz1Qcd8fxGXTw+ND
         LsBDyDwy5x9gg7/hggiZXODI/9L7OxMHYxwrLeao8nzoE8z9pN8ti0iMtwxN2w0YA9zt
         qN+JRG6wOnCdSk9ALdXI9snwi9ivKNMubqG+Jk6BixLu9BucBkug9nsUhCZlMwEwUlar
         vjWDYmqnaWiruKqIhFCX451xRWwNFUXqVVuJMt8MLEVDfWNsNFEFxx4L/jTm/a+VsnDb
         lC2QduIP8kvforYqflOZkrEctoBsz8ybAJogFm43W8uwMo3FXi7FTi+wIs3NqRRk0C/E
         eAMg==
X-Forwarded-Encrypted: i=1; AJvYcCU6FwbuT+t3VrGZMz37lft84SNspt1gveOyzHKrtgYJsWz+k3NWRV+frApr85j5xQ003EOTEDAYC/YreAe4imE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCr1Kt0CU/VXZKHm58lP2pr85ea352+RuI1oqRvNjNCag3mQu9
	genxqrLYTY2gze+Kl+8z0I7GOEUxa/We9rT1o4Vd5b7GHFG7cwWeflAsw+pk+KErkP78dj7nvIY
	O6EOmEwBsyJrkhdsAZXXXV87G6gAFAF9HrG5a4B2CHYvQYgITlpM8s7JVAEoo3fAdC08gqwKD/H
	Hn7r60biVWUo47s85GjG+6tapFoAK6fw0sQmQhAtPgVXgvyA==
X-Gm-Gg: AZuq6aJBDu5CcfJZH4HJkLcC4kourEBJR7hVkAlgpXKaX4iNWu2JwbR2IdqoZH0lyLg
	fHzxdnEHf1jkWilJn09XNVAWyjhxrc1Jgm3i1Mb2LgAigDBqqukDdcwTvzWjkm+LxqCQcoDtELQ
	xwyr0v+Rj2Cd4/5NLwqyxiOR4qPL8eNp0RW5AroD467jxztu3WdKMT9deRRtwnG3QwRBofOzc+6
	Ea9
X-Received: by 2002:a05:7300:dc88:b0:2ba:6723:5061 with SMTP id 5a478bee46e88-2ba6723559dmr2522941eec.8.1770690901426;
        Mon, 09 Feb 2026 18:35:01 -0800 (PST)
X-Received: by 2002:a05:7300:dc88:b0:2ba:6723:5061 with SMTP id
 5a478bee46e88-2ba6723559dmr2522920eec.8.1770690900837; Mon, 09 Feb 2026
 18:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904174325.it.487-kees@kernel.org> <CALvbMcB=DGBizanckW_YJdRYBbG4=2TsLi30yp5CacR00UGPGQ@mail.gmail.com>
In-Reply-To: <CALvbMcB=DGBizanckW_YJdRYBbG4=2TsLi30yp5CacR00UGPGQ@mail.gmail.com>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 18:34:49 -0800
X-Gm-Features: AZwV_Qg9yqzIFQfiyHN0OUpbQjdFFMRYUfs6QHoSDeimWsbiS5Yp-OLEefhSeBA
Message-ID: <CALvbMcCE034Qi_cO80pSytykN_yC-PNhnE1zVsPXz+=_gwPh3w@mail.gmail.com>
Subject: Re: [PATCH v4] Fix sanitizer attribute infrastructure to use standard
 TREE_LIST format [PR113264]
To: Kees Cook <kees@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>,
        Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>,
        Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAxOSBTYWx0ZWRfX7bH8RC/d842a
 pcxPJh/rb6BmR/RLpe+pyDxocB2lihgkiqu2D1MSjKQjPweE8EqG1pK66cPNX+Ia05iHqgKP6/0
 8j8wK6hBrWDF3+5gt92HFmPNpBRLxCx+xHUN6s8oj6aNVF7lAXwb6ddLXWAb+mHeozY9298ioKY
 AV0PIrqrgDFf8PgBwBOMzOVYkwoyOQMzYBn7ROJirgsK07uzdyVF0nYfUEy4LwsWZ/nTJ94dpZD
 yG1b0g+OTnUJS3CU3UFm6eWpz3Ei28vPkRZnDJwt0JJvpQ5DZc7W+NrXd8Vg8yPtOlMDrQYDkt4
 kqVLyNv0Te5i+VvOYcrORsoPoVvEdQeP10zZsabqQA0fV6VY+zB1+PirOxVulQzgocF0NgUJl+M
 wkQOFnuRrvimrp1/WMBn8ckKMn+YK8Her9vQ2DWy4icvvhCpM8FC+26cyw/qieUO7LlDRxEOLQ9
 93y5qscaHAg5RnBkt1w==
X-Proofpoint-ORIG-GUID: cxLyC0--CH-E1nSSb5tssmopolSOv3YA
X-Authority-Analysis: v=2.4 cv=XfuEDY55 c=1 sm=1 tr=0 ts=698a9956 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=AGhreytgnoV0wlS_G08A:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: cxLyC0--CH-E1nSSb5tssmopolSOv3YA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100019

On Mon, Feb 9, 2026 at 12:28=E2=80=AFAM Andrew Pinski
<andrew.pinski@oss.qualcomm.com> wrote:
>
> On Thu, Sep 4, 2025 at 10:43=E2=80=AFAM Kees Cook <kees@kernel.org> wrote=
:
> >
> > The __attribute__((__copy__)) functionality was crashing when copying
> > sanitizer-related attributes because these attributes violated the stan=
dard
> > GCC attribute infrastructure by storing INTEGER_CST values directly ins=
tead
> > of wrapping them in TREE_LIST like all other attributes.
> >
> > Wrap sanitizer attributes INTEGER_CST values in TREE_LIST structures
> > to follow the same pattern as other attributes. This eliminates the
> > copy_list() crashes when copying sanitizer attributes:
> >
> > test.c:4:1: internal compiler error: tree check: expected tree that con=
tains =E2=80=98common=E2=80=99 structure, have =E2=80=98integer_cst=E2=80=
=99 in copy_list, at tree.cc:1427
> >     4 | __attribute__((__copy__(__tanh)));
> >       | ^~~~~~~~~~~~~
> > 0x859d06 tree_contains_struct_check_failed(tree_node const*, tree_node_=
structure_enum, char const*, int, char const*)
> >         ../../gcc/gcc/tree.cc:9126
> > 0x860f78 contains_struct_check(tree_node*, tree_node_structure_enum, ch=
ar const*, int, char const*)
> >         ../../gcc/gcc/tree.h:3748
> > 0x860f78 copy_list(tree_node*)
> >         ../../gcc/gcc/tree.cc:1427
> > 0xa755a5 handle_copy_attribute
> >         ../../gcc/gcc/c-family/c-attribs.cc:3077
>
>
> I am not a fan of the wrapping because it increases the memory usage
> slightly but it is required since the rest of the attributes code
> requires TREE_LIST here.
>
> So Ok.  I will do final testing either Monday or Tuesday and push it afte=
r that.

So this causes some ICEs in the testsuite:
FAIL: c-c++-common/asan/inline-kernel.c   -O0  (internal compiler
error: in tree_to_sanitize_code_type, at tree.cc:6704)

0xa4376b fancy_abort(char const*, int, char const*)
        /home/apinski/src/upstream-gcc-new/gcc/gcc/diagnostics/context.cc:1=
812
0x92f581 tree_to_sanitize_code_type(tree_node const*)
        /home/apinski/src/upstream-gcc-new/gcc/gcc/tree.cc:6704
0x92f581 tree_to_sanitize_code_type(tree_node const*)
        /home/apinski/src/upstream-gcc-new/gcc/gcc/tree.cc:6702
0x128bea2 print_no_sanitize_attr_value
        /home/apinski/src/upstream-gcc-new/gcc/gcc/tree-cfg.cc:8223
0x128bea2 dump_function_to_file(tree_node*, _IO_FILE*, dump_flag)
        /home/apinski/src/upstream-gcc-new/gcc/gcc/tree-cfg.cc:8276


Looks like you forgot to update dump_function_to_file too.
Can you double check all of the locations that use
tree_to_sanitize_code_type to make sure they all have been fixed?

Thanks,
Andrew

>
> Thanks,
> Andrew
>
> >
> > gcc/c-family/ChangeLog:
> >
> >         PR c/113264
> >         * c-attribs.cc (add_no_sanitize_value): Store INTEGER_CST value=
s
> >         wrapped in TREE_LIST following standard attribute conventions.
> >         (handle_no_sanitize_attribute): Handle both original string
> >         arguments and copied INTEGER_CST values from TREE_LIST format.
> >
> > gcc/ChangeLog:
> >
> >         PR c/113264
> >         * asan.h (sanitize_flags_p): Extract sanitizer flags from
> >         TREE_LIST wrapper instead of directly from INTEGER_CST.
> >
> > gcc/d/ChangeLog:
> >
> >         PR c/113264
> >         * d-attribs.cc (d_handle_no_sanitize_attribute): Store INTEGER_=
CST
> >         values wrapped in TREE_LIST following standard conventions.
> >
> > gcc/testsuite/ChangeLog:
> >
> >         PR c/113264
> >         * gcc.dg/pr113264.c: New test.
> >         * gcc.dg/pr113264-asan-no-instrumentation.c: New test validatin=
g
> >         that copied sanitizer attributes prevent ASAN instrumentation.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Indu Bhagat <indu.bhagat@oracle.com>
> > Cc: Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>
> > Cc: Qing Zhao <qing.zhao@oracle.com>
> > Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
> > ---
> >  gcc/asan.h                                    |   8 +-
> >  .../gcc.dg/pr113264-asan-no-instrumentation.c |  60 ++++++++++
> >  gcc/testsuite/gcc.dg/pr113264.c               | 107 ++++++++++++++++++
> >  gcc/c-family/c-attribs.cc                     |  49 +++++---
> >  gcc/d/d-attribs.cc                            |  17 ++-
> >  5 files changed, 221 insertions(+), 20 deletions(-)
> >  create mode 100644 gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentati=
on.c
> >  create mode 100644 gcc/testsuite/gcc.dg/pr113264.c
> >
> > diff --git a/gcc/asan.h b/gcc/asan.h
> > index a24562f67a29..f5dc3d7ceb8d 100644
> > --- a/gcc/asan.h
> > +++ b/gcc/asan.h
> > @@ -253,7 +253,13 @@ sanitize_flags_p (sanitize_code_type flag,
> >      {
> >        tree value =3D lookup_attribute ("no_sanitize", DECL_ATTRIBUTES =
(fn));
> >        if (value)
> > -       result_flags &=3D ~tree_to_uhwi (TREE_VALUE (value));
> > +       {
> > +         /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> > +         tree attr_args =3D TREE_VALUE (value);
> > +         gcc_assert (attr_args && TREE_CODE (attr_args) =3D=3D TREE_LI=
ST);
> > +         sanitize_code_type no_sanitize_flags =3D tree_to_sanitize_cod=
e_type (TREE_VALUE (attr_args));
> > +         result_flags &=3D ~no_sanitize_flags;
> > +       }
> >      }
> >
> >    return result_flags;
> > diff --git a/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c b/=
gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
> > new file mode 100644
> > index 000000000000..812c67c33086
> > --- /dev/null
> > +++ b/gcc/testsuite/gcc.dg/pr113264-asan-no-instrumentation.c
> > @@ -0,0 +1,60 @@
> > +/* PR c/113264 - __attribute__((copy)) crashes with sanitizer attribut=
es
> > +   Test that copied no_sanitize_address attributes prevent ALL ASAN in=
strumentation.
> > +   This file should have NO ASAN calls since all functions have the at=
tribute.
> > +   { dg-do compile }
> > +   { dg-options "-fsanitize=3Daddress" }
> > +   { dg-skip-if "no address sanitizer" { no_fsanitize_address } } */
> > +
> > +/* Original function with no_sanitize_address */
> > +__attribute__((no_sanitize_address))
> > +int original (int *p, int *q)
> > +{
> > +  *p =3D 42;
> > +  return *q;
> > +}
> > +
> > +/* Copy the attribute - should also have no_sanitize_address */
> > +__typeof(original) copy1 __attribute__((__copy__(original)));
> > +int copy1 (int *p, int *q)
> > +{
> > +  *p =3D 43;
> > +  return *q;
> > +}
> > +
> > +/* Another copy - should also have no_sanitize_address */
> > +__typeof(original) copy2 __attribute__((__copy__(original)));
> > +int copy2 (int *p, int *q)
> > +{
> > +  *p =3D 44;
> > +  return *q;
> > +}
> > +
> > +/* Copy from a copy - should still have no_sanitize_address */
> > +__typeof(copy1) copy_of_copy __attribute__((__copy__(copy1)));
> > +int copy_of_copy (int *p, int *q)
> > +{
> > +  *p =3D 45;
> > +  return *q;
> > +}
> > +
> > +int separate_decl (void);
> > +__attribute__((noinline)) int separate_decl (void);
> > +
> > +__attribute__((__copy__(separate_decl), no_sanitize_address))
> > +int copy_and_annotated_alias (int *p, int *q)
> > +{
> > +  *p =3D 42;
> > +  return *q;
> > +}
> > +
> > +__attribute__((__copy__(separate_decl), no_sanitize("address")))
> > +int copy_and_annotated_string (int *p, int *q)
> > +{
> > +  *p =3D 42;
> > +  return *q;
> > +}
> > +
> > +/* Since ALL functions have no_sanitize_address (either directly or co=
pied),
> > +   there should be NO ASAN instrumentation calls in the entire file. *=
/
> > +/* { dg-final { scan-assembler-not "__asan_report_store" } } */
> > +/* { dg-final { scan-assembler-not "__asan_report_load" } } */
> > diff --git a/gcc/testsuite/gcc.dg/pr113264.c b/gcc/testsuite/gcc.dg/pr1=
13264.c
> > new file mode 100644
> > index 000000000000..2a49965e26fd
> > --- /dev/null
> > +++ b/gcc/testsuite/gcc.dg/pr113264.c
> > @@ -0,0 +1,107 @@
> > +/* PR c/113264 - __attribute__((copy)) crashes with sanitizer attribut=
es
> > +   Test that the copy attribute correctly handles sanitizer attributes
> > +   which store their arguments as INTEGER_CST values rather than TREE_=
LIST.
> > +   { dg-do compile }
> > +   { dg-options "-O2" } */
> > +
> > +/* Test copying no_sanitize_address attribute.  */
> > +__attribute__((no_sanitize_address)) void f1 (void);
> > +__typeof(f1) f1_copy __attribute__((__copy__(f1)));
> > +
> > +/* Test copying no_sanitize_thread attribute.  */
> > +__attribute__((no_sanitize_thread)) void f2 (void);
> > +__typeof(f2) f2_copy __attribute__((__copy__(f2)));
> > +
> > +/* Test copying no_sanitize_undefined attribute.  */
> > +__attribute__((no_sanitize_undefined)) void f3 (void);
> > +__typeof(f3) f3_copy __attribute__((__copy__(f3)));
> > +
> > +/* Test copying no_sanitize_coverage attribute.  */
> > +__attribute__((no_sanitize_coverage)) void f4 (void);
> > +__typeof(f4) f4_copy __attribute__((__copy__(f4)));
> > +
> > +/* Test copying no_sanitize attribute with string arguments.  */
> > +__attribute__((no_sanitize("address"))) void f5 (void);
> > +__typeof(f5) f5_copy __attribute__((__copy__(f5)));
> > +
> > +__attribute__((no_sanitize("thread"))) void f6 (void);
> > +__typeof(f6) f6_copy __attribute__((__copy__(f6)));
> > +
> > +__attribute__((no_sanitize("undefined"))) void f7 (void);
> > +__typeof(f7) f7_copy __attribute__((__copy__(f7)));
> > +
> > +/* Test copying multiple sanitizer flags.  */
> > +__attribute__((no_sanitize("address", "thread"))) void f8 (void);
> > +__typeof(f8) f8_copy __attribute__((__copy__(f8)));
> > +
> > +/* Test the original bug report case.  This may trigger a warning
> > +   about conflicting with a built-in function name.  */
> > +__attribute__((no_sanitize_address)) void h (void);
> > +__typeof(h) tanhf64 __attribute__((__copy__(h)));
> > +/* { dg-warning "conflicting types for built-in function" "" { target =
*-*-* } .-1 } */
> > +
> > +/* Test copying from a function pointer variable - this should trigger=
 a warning.  */
> > +__attribute__((no_sanitize_address)) void f9 (void);
> > +void (*f9_ptr)(void) =3D f9; /* { dg-message "symbol 'f9_ptr' referenc=
ed" } */
> > +__typeof(f9) f9_ptr_copy __attribute__((__copy__(*f9_ptr))); /* { dg-w=
arning "'copy' attribute ignored" } */
> > +
> > +/* Test with actual function definitions to ensure attributes are prop=
erly applied.  */
> > +__attribute__((no_sanitize_address))
> > +void actual_func (int *p)
> > +{
> > +  *p =3D 100;
> > +}
> > +
> > +__typeof(actual_func) actual_func_copy __attribute__((__copy__(actual_=
func)));
> > +
> > +void actual_func_copy (int *p)
> > +{
> > +  *p =3D 200;
> > +}
> > +
> > +/* Test copying sanitizer attributes along with other attributes.  */
> > +__attribute__((no_sanitize_address, noinline, cold))
> > +void multi_attr (void);
> > +
> > +__typeof(multi_attr) multi_attr_copy __attribute__((__copy__(multi_att=
r)));
> > +
> > +/* Verify that the copy attribute works with function declarations tha=
t
> > +   have sanitizer attributes applied via separate declarations.  */
> > +void separate_decl (void);
> > +__attribute__((no_sanitize_address)) void separate_decl (void);
> > +__typeof(separate_decl) separate_decl_copy __attribute__((__copy__(sep=
arate_decl)));
> > +
> > +/* Test combining copy attribute with additional no_sanitize attribute=
s.
> > +   The copied function should have both the original no_sanitize_addre=
ss
> > +   and the new no_sanitize flags.  */
> > +__attribute__((no_sanitize_address))
> > +int combined_original (int *p, int *q)
> > +{
> > +  *p =3D 42;
> > +  return *q;
> > +}
> > +
> > +/* Copy the no_sanitize_address attribute and add no_sanitize for alig=
nment.  */
> > +__typeof(combined_original) combined_copy1 __attribute__((__copy__(com=
bined_original), no_sanitize("alignment")));
> > +
> > +/* Test with multiple no_sanitize attributes on original.  */
> > +__attribute__((no_sanitize("address", "undefined")))
> > +int combined_original2 (int *p, int *q)
> > +{
> > +  *p =3D 44;
> > +  return *q;
> > +}
> > +
> > +/* Copy existing sanitizer attributes and add more.  */
> > +__typeof(combined_original2) combined_copy2 __attribute__((__copy__(co=
mbined_original2), no_sanitize("alignment")));
> > +
> > +/* Test with no_sanitize_undefined on original.  */
> > +__attribute__((no_sanitize_undefined))
> > +int combined_original3 (int *p, int *q)
> > +{
> > +  *p =3D 46;
> > +  return *q;
> > +}
> > +
> > +/* Copy and add no_sanitize_address - combining different sanitizer at=
tributes.  */
> > +__typeof(combined_original3) combined_copy3 __attribute__((__copy__(co=
mbined_original3), no_sanitize_address));
> > diff --git a/gcc/c-family/c-attribs.cc b/gcc/c-family/c-attribs.cc
> > index 1e3a94ed9493..e629601579ef 100644
> > --- a/gcc/c-family/c-attribs.cc
> > +++ b/gcc/c-family/c-attribs.cc
> > @@ -1425,20 +1425,27 @@ add_no_sanitize_value (tree node, sanitize_code=
_type flags)
> >    tree attr =3D lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (node=
));
> >    if (attr)
> >      {
> > -      sanitize_code_type old_value =3D
> > -       tree_to_sanitize_code_type (TREE_VALUE (attr));
> > +      /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> > +      tree attr_args =3D TREE_VALUE (attr);
> > +      gcc_assert (attr_args && TREE_CODE (attr_args) =3D=3D TREE_LIST)=
;
> > +      sanitize_code_type old_value =3D tree_to_sanitize_code_type (TRE=
E_VALUE (attr_args));
> > +
> >        flags |=3D old_value;
> >
> >        if (flags =3D=3D old_value)
> >         return;
> >
> > -      TREE_VALUE (attr) =3D build_int_cst (uint64_type_node, flags);
> > +      tree new_value =3D build_tree_list (NULL_TREE,
> > +                                       build_int_cst (uint64_type_node=
, flags));
> > +      TREE_VALUE (attr) =3D new_value;
> >      }
> >    else
> > -    DECL_ATTRIBUTES (node)
> > -      =3D tree_cons (get_identifier ("no_sanitize"),
> > -                  build_int_cst (uint64_type_node, flags),
> > -                  DECL_ATTRIBUTES (node));
> > +    {
> > +      tree attr_value =3D build_tree_list (NULL_TREE,
> > +                                        build_int_cst (uint64_type_nod=
e, flags));
> > +      DECL_ATTRIBUTES (node) =3D tree_cons (get_identifier ("no_saniti=
ze"), attr_value,
> > +                                         DECL_ATTRIBUTES (node));
> > +    }
> >  }
> >
> >  /* Handle a "no_sanitize" attribute; arguments as in
> > @@ -1456,17 +1463,29 @@ handle_no_sanitize_attribute (tree *node, tree =
name, tree args, int,
> >        return NULL_TREE;
> >      }
> >
> > -  for (; args; args =3D TREE_CHAIN (args))
> > +  /* Handle both original string arguments and copied attributes that
> > +     have already been processed into INTEGER_CST wrapped in TREE_LIST=
.  */
> > +  if (args && TREE_CODE (args) =3D=3D TREE_LIST
> > +      && TREE_VALUE (args) && TREE_CODE (TREE_VALUE (args)) =3D=3D INT=
EGER_CST)
> >      {
> > -      tree id =3D TREE_VALUE (args);
> > -      if (TREE_CODE (id) !=3D STRING_CST)
> > +      /* This is a copied attribute with the flags already processed. =
 */
> > +      flags =3D tree_to_sanitize_code_type (TREE_VALUE (args));
> > +    }
> > +  else
> > +    {
> > +      /* Process original string arguments.  */
> > +      for (; args; args =3D TREE_CHAIN (args))
> >         {
> > -         error ("%qE argument not a string", name);
> > -         return NULL_TREE;
> > -       }
> > +         tree id =3D TREE_VALUE (args);
> > +         if (TREE_CODE (id) !=3D STRING_CST)
> > +           {
> > +             error ("%qE argument not a string", name);
> > +             return NULL_TREE;
> > +           }
> >
> > -      char *string =3D ASTRDUP (TREE_STRING_POINTER (id));
> > -      flags |=3D parse_no_sanitize_attribute (string);
> > +         char *string =3D ASTRDUP (TREE_STRING_POINTER (id));
> > +         flags |=3D parse_no_sanitize_attribute (string);
> > +       }
> >      }
> >
> >    add_no_sanitize_value (*node, flags);
> > diff --git a/gcc/d/d-attribs.cc b/gcc/d/d-attribs.cc
> > index 53aea5e2e904..342702b05acb 100644
> > --- a/gcc/d/d-attribs.cc
> > +++ b/gcc/d/d-attribs.cc
> > @@ -1424,17 +1424,26 @@ d_handle_no_sanitize_attribute (tree *node, tre=
e name, tree args, int,
> >       merge existing flags if no_sanitize was previously handled.  */
> >    if (tree attr =3D lookup_attribute ("no_sanitize", DECL_ATTRIBUTES (=
*node)))
> >      {
> > -      sanitize_code_type old_value =3D
> > -       tree_to_sanitize_code_type (TREE_VALUE (attr));
> > +      /* Extract the INTEGER_CST from the TREE_LIST wrapper.  */
> > +      tree attr_args =3D TREE_VALUE (attr);
> > +      gcc_assert (attr_args && TREE_CODE (attr_args) =3D=3D TREE_LIST)=
;
> > +      sanitize_code_type old_value =3D tree_to_sanitize_code_type (TRE=
E_VALUE (attr_args));
> > +
> >        flags |=3D old_value;
> >
> >        if (flags !=3D old_value)
> > -       TREE_VALUE (attr) =3D build_int_cst (d_ulong_type, flags);
> > +       {
> > +         tree new_value =3D build_tree_list (NULL_TREE,
> > +                                            build_int_cst (d_ulong_typ=
e, flags));
> > +         TREE_VALUE (attr) =3D new_value;
> > +       }
> >      }
> >    else
> >      {
> > +      tree attr_value =3D build_tree_list (NULL_TREE,
> > +                                         build_int_cst (d_ulong_type, =
flags));
> >        DECL_ATTRIBUTES (*node) =3D tree_cons (get_identifier ("no_sanit=
ize"),
> > -                                          build_int_cst (d_ulong_type,=
 flags),
> > +                                          attr_value,
> >                                            DECL_ATTRIBUTES (*node));
> >      }
> >
> > --
> > 2.34.1
> >
