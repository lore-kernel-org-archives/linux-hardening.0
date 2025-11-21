Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429622BD5AF
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750418; cv=none; b=a0D1IzHVPLbRjUSH+tJR/+5AtYJ9iRVPJMN7gCErI+4JWxSygD79oEz2hgNcAzlPP2ntqyvnG7xFVhvg6a+6/I6VH6sFgbu6lLg0m4A4VmfgBQiLQ5uspMiqkjPVnlLYrN6UBLtoM1vo2JLrLaQepn4xn/1JqGbgt+DGPyFiVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750418; c=relaxed/simple;
	bh=/nPc4/HB5nEImF/Co5S03uBwqh0G0o7aYxPl3mMmS0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eqc37mpkJfmqUDuIYY5mJdnOU7R2bVoJJkpZJxbLnXpT8YoDXomfPzRuMvsfwaD90H630FhWvQqHnTjdgWFcBr6tDkrsBCncj0RcrQitTewJH+jJZ8HfixDk1PsgT5UemBZLHhJwj4ssmLWJAFacZtgX7qpZshSePoFXnSWOkg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K+VrIVby; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fqe+m5g+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K+VrIVby";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fqe+m5g+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALFphx93139652
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 18:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hJw8kVfzPqDQSR+R7mX9c0951/4Rj9fkzDd3yZzW+e4=; b=K+VrIVbyRd1aALrM
	G/Tgxa1WgHE6CaFRMzU7TsiuVSa5KI4zf0z8Pw1SaatxyUktNbxLS+3DJ1mYtS8P
	DqhrdtdrXhMXQ/Oo5rVqwiuEKF54f/DN8cAk4NVIdC560GC+2Bz7g7k+NEAUG7QN
	FPVbjGsJaRrlayUDkcstXBNDVfliRgBgZcgCXzeuKqI/2FnAnR9JuvKkqWMSse4p
	c0IxBU9282uujjrMZQtts9rwJWzwBU0F6lc1nsSPtcDmthpPCMBytYeAPuBY7AV0
	bA3PDwD+Spq1PIvFxziChu+2ZUCMNrWBtbH0d2PTOPVAfHOrcKq70lUXq4uKMEwC
	8U7Pag==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajmppj184-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 18:40:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b98e6ff908aso6735414a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 10:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763750412; x=1764355212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJw8kVfzPqDQSR+R7mX9c0951/4Rj9fkzDd3yZzW+e4=;
        b=fqe+m5g+y7K0L+Ty5JyCnWBsjaLSF9bBSY7pA2tIYoxkQdywQz+uM/Sj0ivxhHJ73K
         qeyky6fdDlHuuM7UdaruIZ/QtQEGL9QJi38aCej4b/Ij8+7PcKIyQmwx2csy6tFqnf9j
         OXvP1QY7hGImVm3Z/P/IdkWEImfabc4+SdAl8EHOhtWYp8Yp76slZ4IO9m4HhPBorqL3
         k7suJM9X1X72OmMOTtO27olcanFaIddX5QAuEF5DPLeRT0A42B+MneUuo79woq1JuoUV
         E6CJuPyR5LtMwJtycBMv6aR+Ij+jnIx+YpM7s9fOo43GqgLhPW7H15HK151NNRRbKCUD
         zzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763750412; x=1764355212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJw8kVfzPqDQSR+R7mX9c0951/4Rj9fkzDd3yZzW+e4=;
        b=StJDnoeaQPWgAEVYa3wKJUm8HGtvzw7Pi/SbAUwRIj+Z+m0Xt+ARCMr+xB5jj9Tozk
         cgtDqpnyxR8hTzk/Apqc8mJg6hCgjifjRv93yhNVeso3dlxHRs0Z2UvGCvhpcIEKPimV
         kxs3t4UK4cft1LDlsr9OTcHIdbEmEyV3r/oE/4y1lU9o1Chd5sO5vcxUyWL3nVP77bNG
         7qiGraqo3lWgapbmRwNn3woAgt691M0CF4LU/9QGr/rsusNHni6h1J0m+dCmI1R3e2zN
         a5oQyArKfLO1FO9XW9Zj9wZ3JC4+2+i7hfoP4lHQx32rJvUlI+XhJy649I1KyhFSxGRg
         q86g==
X-Forwarded-Encrypted: i=1; AJvYcCUXUF6sUX1FojeMbYb/4pESkqCNNEyEjlJfhnNKZsOayXN1xU0x7J0c5e9PM8OwPJZ3rsTs4w5YyaAqqG8dV5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsnGsJoWCPyoUW3oWXqQq8JIWelu+naswK6G9n2/wPqGFQwGvc
	/HI4g7ug2acPUcJCTYeLR9dA560UHcLtZaxgof5M9k5I8VvqonjEe3nPnKXOrbDQ3MGSLNuJXZK
	Bz5dbVIVMqQfXrNri0ornKus+CePxb/ot3HhYd2NgpnvsNW3VBC9hqh2TSN/N5gY8X2zYHZuDj5
	ap4Q9ihf92h7Nis+UwEOLk17mWvbsb9dYG9wNr8aDAEGWxuSA8ncBb3g==
X-Gm-Gg: ASbGnctfa0oXrQGj3vysJH8+9QgABB6xB6EhgmQ/e3PEW9rYZxjZjdzwM84pOI/oljQ
	ni/q5p4xO73gMQhhZ/z0E2158tTBFJTZXp9gIhwYbosdzTV8eyFZ5J+176nqF5nTpUhb9k7wpES
	ewdKt+WeCQyOLz2UHHSzoKHG/UGHl2caUmytNDNAjiSS+DDS8Dw0B9Ar6MGMeJABgV
X-Received: by 2002:a05:7022:2495:b0:11b:9386:7ed1 with SMTP id a92af1059eb24-11c9d871499mr1389103c88.46.1763750411827;
        Fri, 21 Nov 2025 10:40:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOAhPeFsDMUlKt0Bx1JtmfSjA2B71qG7LKsm+YQ26S26PwupmZbHDs1aevXH84FG6kmGj2eLH1bc42FBHNnCs=
X-Received: by 2002:a05:7022:2495:b0:11b:9386:7ed1 with SMTP id
 a92af1059eb24-11c9d871499mr1389094c88.46.1763750411333; Fri, 21 Nov 2025
 10:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121182426.work.116-kees@kernel.org>
In-Reply-To: <20251121182426.work.116-kees@kernel.org>
From: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 10:39:59 -0800
X-Gm-Features: AWmQ_bnDcr6E9Svnd-mH41Q6RtK4pp6LuKgQ_ZwSpTKyncq0f0r9QDq8tJMgoQU
Message-ID: <CALvbMcDEc_C23TvGp9wpWkKvePM=sJ-3u0oQ4y45_SG9S6cn6w@mail.gmail.com>
Subject: Re: [PATCH] aarch64: Extract aarch64_indirect_branch_asm for sibcall codegen
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Rpcsqv6c4d8XL9Vty2LWsnE8hoMFMdbj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDE0MCBTYWx0ZWRfX/tiWol/+eS5D
 W9d+TJ6+5qf6YPKV2Qn+Wx/QsQpLWB5f0ItswTVTgUbeIsQM+D0tD/5HH8n+b8y1FNXKZom2nXb
 Q9uVQ/K0XDInK7DE8ZByMCp/fwI01tf6IHc4DpsLdLE5KUB1BgyhpVe7LYsrYyBGL8KhjAOFAPx
 p1llmcx8gp298qy21svZ6Db6Tf6lDqyQhA+qMw9UNCs6HlP08vRqaQ7QGooc03Dlm7vjeVRiYy+
 YuW6uRLLiz8L9ov3V6QaUB+qPe4hHdHsTf3R+V4RIWY0E/NJ9vJhR8Zt9DdYrVdpMJxtMgCr2rk
 kcaeQ2JiND0i0VIIQJETsIDPctDliiABnwhF6oMQMgs4bCAsiOyIX9SUysZD2HOAsfrV0jDfh/B
 2wFVC4TywinVanIqcv//aN1NV1bVig==
X-Proofpoint-GUID: Rpcsqv6c4d8XL9Vty2LWsnE8hoMFMdbj
X-Authority-Analysis: v=2.4 cv=CK4nnBrD c=1 sm=1 tr=0 ts=6920b20c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=z0EVfJPyfq8qr-g_9h0A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210140

On Fri, Nov 21, 2025 at 10:24=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Extract indirect branch assembly generation into a new function
> aarch64_indirect_branch_asm, paralleling the existing
> aarch64_indirect_call_asm function.  Replace the open-coded versions in
> the sibcall patterns (*sibcall_insn and *sibcall_value_insn) so there
> is a common helper for indirect branches where things like SLS mitigation
> need to be handled.
>
> gcc/ChangeLog:
>
>         * config/aarch64/aarch64-protos.h (aarch64_indirect_branch_asm):
>         Declare.
>         * config/aarch64/aarch64.cc (aarch64_indirect_branch_asm): New
>         function to generate indirect branch with SLS barrier.
>         * config/aarch64/aarch64.md (*sibcall_insn): Use
>         aarch64_indirect_branch_asm.
>         (*sibcall_value_insn): Likewise.

This is ok (will push it later today for you since you don't have
write access) with one minor change ...

>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  gcc/config/aarch64/aarch64-protos.h |  1 +
>  gcc/config/aarch64/aarch64.md       | 10 ++--------
>  gcc/config/aarch64/aarch64.cc       | 12 ++++++++++++
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/gcc/config/aarch64/aarch64-protos.h b/gcc/config/aarch64/aar=
ch64-protos.h
> index a9e407ba340e..50623c3bed2e 100644
> --- a/gcc/config/aarch64/aarch64-protos.h
> +++ b/gcc/config/aarch64/aarch64-protos.h
> @@ -1272,6 +1272,7 @@ tree aarch64_resolve_overloaded_builtin_general (lo=
cation_t, tree, void *);
>
>  const char *aarch64_sls_barrier (int);
>  const char *aarch64_indirect_call_asm (rtx);
> +const char *aarch64_indirect_branch_asm (rtx);

`extern` should be in the front. Like what is done below for the other
ones (and not like the ones above; I will fix that separately).

Thanks again for separating this out from the KCFI patch.

Thanks,
Andrew

>  extern bool aarch64_harden_sls_retbr_p (void);
>  extern bool aarch64_harden_sls_blr_p (void);
>
> diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.m=
d
> index 855df791bae7..de6b1d0ed06b 100644
> --- a/gcc/config/aarch64/aarch64.md
> +++ b/gcc/config/aarch64/aarch64.md
> @@ -1581,10 +1581,7 @@
>    "SIBLING_CALL_P (insn)"
>    {
>      if (which_alternative =3D=3D 0)
> -      {
> -       output_asm_insn ("br\\t%0", operands);
> -       return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> -      }
> +      return aarch64_indirect_branch_asm (operands[0]);
>      return "b\\t%c0";
>    }
>    [(set_attr "type" "branch, branch")
> @@ -1601,10 +1598,7 @@
>    "SIBLING_CALL_P (insn)"
>    {
>      if (which_alternative =3D=3D 0)
> -      {
> -       output_asm_insn ("br\\t%1", operands);
> -       return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> -      }
> +      return aarch64_indirect_branch_asm (operands[1]);
>      return "b\\t%c1";
>    }
>    [(set_attr "type" "branch, branch")
> diff --git a/gcc/config/aarch64/aarch64.cc b/gcc/config/aarch64/aarch64.c=
c
> index 6dfdaa4fb9b0..89097e237728 100644
> --- a/gcc/config/aarch64/aarch64.cc
> +++ b/gcc/config/aarch64/aarch64.cc
> @@ -30822,6 +30822,18 @@ aarch64_indirect_call_asm (rtx addr)
>    return "";
>  }
>
> +/* Generate assembly for AArch64 indirect branch instruction.  ADDR is t=
he
> +   target address register.  Returns any additional barrier instructions
> +   needed for SLS (Straight Line Speculation) mitigation.  */
> +
> +const char *
> +aarch64_indirect_branch_asm (rtx addr)
> +{
> +  gcc_assert (REG_P (addr));
> +  output_asm_insn ("br\t%0", &addr);
> +  return aarch64_sls_barrier (aarch64_harden_sls_retbr_p ());
> +}
> +
>  /* Emit the assembly instruction to load the thread pointer into DEST.
>     Select between different tpidr_elN registers depending on -mtp=3D set=
ting.  */
>
> --
> 2.34.1
>
