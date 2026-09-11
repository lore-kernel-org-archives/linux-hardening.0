Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAA4AA57E
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154659; cv=pass; b=XHicFn/iKHUq4jIMHdgGtL2EUdRQYsiY6NNSSqZzLf7324CoM2zqtp4V8hCB/4f8uiG0Knd4ojZvDwzmtGxOibBODg8oEWj0ki4+1cCQHAMl52omGb7pQ6LKNbPvTXmQeP6WE+11gH4ruK11LmWP7wvHoM7BhhWdPQ8FxA98wVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154659; c=relaxed/simple;
	bh=Fdw+r3dysTF3WjqXT9axUm7jMijJrnIOkKcC5AZjbbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3CteeTWsj1Fn6+/RtCcc6adObA4NFNzdHywrtOVq1X6jybpqcP8EekJNs8pzIFwU5k4HO3/0u+0SK/WrvTRcTSf6xBQnbYNmPgjx/bdjtYT6OCcM5htLywukKOvR104O1MQawISgZQ2J4k8fQUoL2YES6/jNB7HU9m+Y4wFBKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0dNBhsS; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0dNBhsS"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-782df51b4c1so934301137.3
        for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 12:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789154651; cv=none;
        d=google.com; s=arc-20260327;
        b=CPVvCtYpzEP3w1PxYFIKN0yLpfr5K0wol8oCmVSKHwq0D4BwDXfsQVzItgkfVRZoUA
         ayXQ88JyHF1UUO5BK4P6+cKCff6eM/Z67KmbAeuNkWb9upw3f0a4Kw74DEnxlUBZK0Bw
         LTN/r78zVEInwpxSMB7x25meo4mm3Y3Jjk7GHg48kS3Uo2jpoRFvvCjrcGjQ1yO+kDvJ
         4tug+ZBqUwfcokiyFEd9NNfgkTmMsrdaTFmSOMRjcb7O4uNa5RiN4YzrAq0nc/j1eBYc
         Ewa16fOmhxSN4aYnH8gAf7pOFqqoJMvL1dvCtAmbezBvL+uGDhcygb6dx5RXa1IT8Jvf
         T0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D9lUlaXsCvPiCPFMAfPhKXQQhy684K2H2SGMPGJQm6U=;
        fh=Uy/8uEgGKoIqEgGm+/qzVS4h1oWcBbZqtO0SE5rDGsU=;
        b=a4DdRdxxmg69LQ7DTOGSZZcustDSFT/JD4hl439F80YlEr9dstAtE4vO+UM2IFMHCd
         1J0+Dd6QVi8EBR7Na+/x01O9FyQurQlkTKwYJfcHU+mXpCXPBa2p1t+ZHFgSUykbZhgf
         5EgdevUXkP4xqgTe867q331yJt0rJVALBXgLAvzK6c/jkoCten4HPT8T+rPrvxEaljtU
         Lwq5EcfRee/6NFOx0hE2u9Imqye2/52DCtkOoeSN1tUQh6R99oogsueiVh0QEI7/qdrh
         1npwgmyxTd/NOAPR6VXIhTH4scKxMosAI4us9E3ngk0ZBhabKUIjULX7bnrrlYzkDcx3
         h9BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789154651; x=1789759451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D9lUlaXsCvPiCPFMAfPhKXQQhy684K2H2SGMPGJQm6U=;
        b=t0dNBhsSX2AQI9wDHg2vq5fkSryk7Mjx1vpHl4tYrx152QTNTv9KybJwEUTZ+gM6eg
         fbGGh0XoNpFPX2NAw3GAklacgT97Kir5k8Leq+0/tch+y9eptRGGaqAe4QaHKPFdGpdg
         qqFvbVX0s9J3tMcC1BoxWl/dS0mmvSqdLMzo99hJgf57mSWokmqVnxeW+MTPMo8+qqNm
         wOH7NKNJ0wTrKc+n9Kb1S55WY7SI/99AkLAGJCPzC2YdiSod0KVONWhgxOZeByYbc516
         f+GTqcZoc0BIUzpuGu5xlgU5k/B2yrTkIHxaV3rIRBUPvTw/reAVQG3VzcRIuPVpJH8n
         MEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154651; x=1789759451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D9lUlaXsCvPiCPFMAfPhKXQQhy684K2H2SGMPGJQm6U=;
        b=S/3uIfapFMTTO6dSPejgSH5+F0t3uQruMVOdxIij+aupjm2hyQwejLpb3J9jJhiVx0
         u0+DaZ77STGG0ZJmWDdTkOBGQET4Bf8mOjUw+myDUzPbkeNP+DsissCMa8EBLxtEJeZ1
         7nkqwwvWH3oLjD+ioH+1jkofjCpNP/nGsQpiw+ERYWy/o7ws1tGLs52SskUUMvP1lreL
         rIQCNElaDWAp2kmvhq7aqPkvQvfNdowiyQJXfzHqEqM4gI8P1gYwi5FuDn4SCQ0cqD++
         ui9qCauHQD53gFUsHnMboMqzzeTV4oQ19kClRYohdLYz5pc6SbnV+eyUtGOLCkDsGwMD
         ZTyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjkRe7v1cbz27aBBp+B6NLZkAIVOlayeyXN2QLhrTBCeNusP4NXbjnF5ie5+C3EwJdRW5yZZUDwMvUvPJBh5A=@vger.kernel.org
X-Gm-Message-State: AFuF++nS4ep0yUMFddnFyFRWfDeI7cr0WOrZEaj5X8soh98UxqEOvJX8
	bn/jgtlJvTaADD1qOCACKXM9tWQGoWEEqB4GN38LyOtJwkMwjhfUPF/CvVADE9xntQE1GXQawW5
	m1UTAV28i4QTUQGuJsIA0FSkesH1g+0pdkBknHg0=
X-Gm-Gg: AYBFou07DmzdM50tmLN80/8Vm/DW/CjaNsnzAO2WfzP1iwtrQAYKHNZCmKzGB719QqS
	Q9iGTU922raRcexh66Tibr7XEr/XH+iPF2r6hdIAq/idB7c/zELIjS6NAK0c51cDCOQ7O2JGqTF
	xgkyLw7Acp1Bn8S9De3pa2yZBIGCGUCjNatdg4Ral5Qw5BS6HUqyOpOu4ijz1Olq5qoZv4qpZ+F
	fr2ygIy+mpAI6RfG3Iw8+fColUVbExIcP8zKpSip6VOSTRpHN9km9n5GMzQH2FpCmVzR1vomZtv
	Ku7tN4gII6VfmUj2z4N9DrK2WFmwzqsbenynRBULrfdleTQiH7U0s20JoFjx3Hi69rFYMwwbRVV
	kfaWf7NgRdg6s+IlYb91i
X-Received: by 2002:a05:6102:55d3:b0:785:eb33:87aa with SMTP id
 ada2fe7eead31-792a7c0cf6dmr6291546137.5.1789154650910; Fri, 11 Sep 2026
 12:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner> <20260911-zyklisch-stuhl-zweit-d61b18a17838@brauner>
In-Reply-To: <20260911-zyklisch-stuhl-zweit-d61b18a17838@brauner>
From: Bill Wendling <morbo@google.com>
Date: Fri, 11 Sep 2026 12:23:54 -0700
X-Gm-Features: AcwNN1XCuxA56YE74BOrs6AnS18Rv8BxhySba1P_h50I4QrnUiuUdff7p6DrTHg
Message-ID: <CAGG=3QUiRinW3B+-zOd2sPdHbu9=Kt+QdE0mQHcK4t06qC6ckA@mail.gmail.com>
Subject: Re: [PATCH 2/2] userns: declare the KUnit-visible helpers whenever
 KUnit is enabled
To: Christian Brauner <brauner@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	kernel test robot <lkp@intel.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:59=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> VISIBLE_IF_KUNIT drops the static qualifier whenever CONFIG_KUNIT is
> enabled but the prototypes for the two helpers it exposes are only
> declared when CONFIG_USER_NS_MAP_KUNIT_TEST is set.
>
>   kernel/user_namespace.c:787:22: warning: no previous prototype for 'ins=
ert_extent' [-Wmissing-prototypes]
>   kernel/user_namespace.c:860:22: warning: no previous prototype for 'sor=
t_idmaps' [-Wmissing-prototypes]
>
> Guard the declarations on CONFIG_KUNIT so they match the definitions.
>
> Fixes: f6f1a2496ba5 ("userns: Add KUnit test suite for uid_gid_map")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609111048.yhHILE11-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202609111305.ta3EOA2x-lkp@i=
ntel.com/
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Feel free to add:

Reviewed-by: Bill Wendling <morbo@google.com>

-bw

> ---
>  include/linux/user_namespace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespac=
e.h
> index 637cd7e91a45..91232053775d 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -208,11 +208,11 @@ extern bool in_userns(const struct user_namespace *=
ancestor,
>  extern bool current_in_userns(const struct user_namespace *target_ns);
>  struct ns_common *ns_get_owner(struct ns_common *ns);
>
> -#if IS_ENABLED(CONFIG_USER_NS_MAP_KUNIT_TEST)
> +#if IS_ENABLED(CONFIG_KUNIT)
>  extern int uid_gid_map_insert_extent(struct uid_gid_map *map,
>                                      struct uid_gid_extent *extent);
>  extern int uid_gid_map_sort(struct uid_gid_map *map);
> -#endif /* CONFIG_USER_NS_MAP_KUNIT_TEST */
> +#endif /* CONFIG_KUNIT */
>
>  #else
>
> --
> 2.53.0
>
