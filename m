Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740B1898FB;
	Wed, 16 Apr 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815860; cv=none; b=H7G9WbEffARWVSUjWKOsL+OFeV6qu3CXbb516+UQYrzjAx73u9jlDejtASzz0XWdVHTWrVKpmRjNRwx4MrtUDFwoqR3+QeY4DaQNT2NWPksly94/I3sNj1AcyTyasrcYh5ZvT8ulDbUf8b5z627oroJCNmxTwIcAOmmuEQeBaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815860; c=relaxed/simple;
	bh=52WAkbxhL8lHhm4E40nmTbAH9lRIUn8LXXhYKUxRAkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRwcq7TswF5a84Hsh86AM1tSyg44RqFOCLEPYoZ0IuaXdE4BRQOehj2GGhf/GP8sUjUq2LOszaV5jO4LXzPJDEAo1P+WDs22suBE1s5jNCh4tYfmc1XlBFs8xWAaOaMAUWVQVWmRSVdpqLf10ZGxgZiLTDedYvoSptHJEGErVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSp5MClW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSp5MClW"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b07698318ebso305751a12.2;
        Wed, 16 Apr 2025 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744815857; x=1745420657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVFtqQNk5rkPP5VSi8xT3sOzTBsKiZnfpOajhh4Y93U=;
        b=QSp5MClWFGdOK2rZ0EGYM3gtHlExbYz5aaahBkShfH3vsOYDTy9TYSfu4PwflPKq3r
         cP+4NL/TlmAs38BHsohZvhd6YGmyyG3e9BvNFm72vWwdpfWIra31hUJoMo3P0dSxDpZE
         r/euG4MGckgbPVq3yTxZkB6vRo32yKklafbLxmOvh3mFgvuGB470+iEwFejpnlOxl25z
         j0/t1+oeN3USOdfie5WXDiR5ddJZN48/YrOCQswQsGJxnwo5QxnznQjEkO8BZNunv1hm
         LP3pqpzMS2KVq48yt/0hVJe8dvA7YJtzEDilOYhHdyQX5U+jP8izGBXYzo9jYKWn3IFC
         diNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744815857; x=1745420657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVFtqQNk5rkPP5VSi8xT3sOzTBsKiZnfpOajhh4Y93U=;
        b=vSOQPx+EYbbMKwNiMCXeGRxdGj0Cif7W2EVCARNSv0i0jkY6XAiR0Uiza00bW/wcVs
         TTp9hyHOZYCrg11plOgUpMRPCr0R02iSW61DH+XNviRkD0mltyvZH9WZhyGV85b1BoRg
         +PQ277SLJJOt39hqbPtVlWwtZbww3NhIdjzSI3FQlDXJyLAIiV8ZYbOw235I9ZTUoW2o
         yPgsBN/l4mrCbtGu9WxjWFsSaYtTCk7imnKWkbqCZ1PCrTM62TFgiI9ExWnxDB1asEme
         BpGc+BvbsLrutPRXxupAFM8eye0PCj/WcKWdh/6rFgSUdCzrde8zB2Vz9U9ZD1ASfwpj
         otQw==
X-Forwarded-Encrypted: i=1; AJvYcCWNRh4T2nk5cAYO+/DopGusxmR4YSDbBd/fgz7+yC4iz8pGZRTXdsSBOlR6d0d1FPbe5IPrOqSrGjV8xJAXMDc=@vger.kernel.org, AJvYcCXVsgN7DNKafiv3C2nABMsGtGEFcpQwej3wR5caHDm7GDNtWLibM1c8T8LRHKNnWU2cGDpMiQ9PNmlw3Wm5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TZDaw/WkjClDLm2cZ3BNAIagTyNYSueRiR7ftN7qQ/aijRZs
	IVWUJyf963AARmrk4dwDU7UXrHx2bKuEGDcpjuIYNQvtL1uWi5aXL59wfFLwWxRMyQlXuwQxkfP
	UvZtwzO9CxR+lCieIvGg3NvZYrMQ=
X-Gm-Gg: ASbGnct5AKE+Zv6stT/0Aa0EpVgsD+qRiAZEUyG0UVSCinK/iZU8+GzGxT733NNpR0G
	qSCjX02ucA/CgvIf2QIAPMnSbavLktU26UxgSN5n07UcYJdKFPak15OOD3XKYIrvuw2Ndvr5/Yt
	xryYI4loTqe0fNO/I1fUwBsUvVyHpTrWxh
X-Google-Smtp-Source: AGHT+IGyfxnt/aNFxXm8FZac7BhXF4m820MtTk5Qy0SGVUawuMIbjEGblrp/5GK7oCsMVC9lWrRKZepGO5Ypf/O3GMc=
X-Received: by 2002:a17:90b:384c:b0:306:b6ae:4d7a with SMTP id
 98e67ed59e1d1-30864165e44mr1146372a91.3.1744815856672; Wed, 16 Apr 2025
 08:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z678TNhCbTk363Tw@kspp> <864c7dd5-0deb-4adb-a1cf-c8a809514d7e@embeddedor.com>
 <217b00f5-d03d-4624-9ba9-d838199ef7b9@embeddedor.com>
In-Reply-To: <217b00f5-d03d-4624-9ba9-d838199ef7b9@embeddedor.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Apr 2025 11:04:04 -0400
X-Gm-Features: ATxdqUGn4UAwWKO9rc3w4V2DzzsBrEKuE_v_1b78ZJI7oY5ijYXBcUz8pBjEKwc
Message-ID: <CADnq5_M5Jv4A5CXAKY2Qd-dhrfmecnauRtVY_ghSsut7i=KNww@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Avoid multiple -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kenneth Feng <kenneth.feng@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you resend, I can't seem to find the original emails.
Additionally, all of the NISLANDS structures are unused in amdgpu, so
those could be removed.

Alex
On Wed, Apr 16, 2025 at 12:48=E2=80=AFAM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi all,
>
> Friendly ping (second one): who can take this patch, please? =F0=9F=99=82
>
> Thanks!
> -Gustavo
>
> On 11/03/25 02:10, Gustavo A. R. Silva wrote:
> > Hi all,
> >
> > Friendly ping: who can take this, please? :)
> >
> > Thanks!
> > --
> > Gustavo
> >
> > On 14/02/25 18:48, Gustavo A. R. Silva wrote:
> >> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> >> getting ready to enable it, globally.
> >>
> >> So, in order to avoid ending up with a flexible-array member in the
> >> middle of other structs, we use the `struct_group_tagged()` helper
> >> to create a new tagged `struct NISLANDS_SMC_SWSTATE_HDR` (and `struct
> >> SISLANDS_SMC_SWSTATE_HDR`). This structures group together all the
> >> members of the flexible `struct NISLANDS_SMC_SWSTATE` (and `struct
> >> SISLANDS_SMC_SWSTATE`) except the flexible array.
> >>
> >> As a result, the array is effectively separated from the rest of the
> >> members without modifying the memory layout of the flexible structure.
> >> We then change the type of the middle struct members currently causing
> >> trouble from `struct NISLANDS_SMC_SWSTATE` to `struct
> >> NISLANDS_SMC_SWSTATE_HDR` (and from `struct SISLANDS_SMC_SWSTATE` to
> >> `struct SISLANDS_SMC_SWSTATE_HDR`).
> >>
> >> We also want to ensure that when new members need to be added to the
> >> flexible structure, they are always included within the newly created
> >> tagged struct. For this, we use `static_assert()`. This ensures that
> >> the memory layout for both the flexible structure and the new tagged
> >> struct is the same after any changes.
> >>
> >> This approach avoids having to implement `struct NISLANDS_SMC_SWSTATE_=
HDR`
> >> (and `struct SISLANDS_SMC_SWSTATE_HDR`) as a completely separate struc=
ture,
> >> thus preventing having to maintain two independent but basically ident=
ical
> >> structures, closing the door to potential bugs in the future.
> >>
> >> We also use `container_of()` whenever we need to retrieve a pointer to
> >> the flexible structure, through which we can access the flexible-array
> >> member, if necessary.
> >>
> >> So, with this changes, fix the following warnings:
> >>
> >> drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/sislands_smc.h:218:49: war=
ning: structure containing a flexible array member is not at the end of ano=
ther
> >> structure [-Wflex-array-member-not-at-end]
> >> drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.h:819:41: warning: =
structure containing a flexible array member is not at the end of another s=
tructure [-
> >> Wflex-array-member-not-at-end]
> >> drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.h:818:41: warning: =
structure containing a flexible array member is not at the end of another s=
tructure [-
> >> Wflex-array-member-not-at-end]
> >> drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.h:817:41: warning: =
structure containing a flexible array member is not at the end of another s=
tructure [-
> >> Wflex-array-member-not-at-end]
> >> drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.h:816:41: warning: =
structure containing a flexible array member is not at the end of another s=
tructure [-
> >> Wflex-array-member-not-at-end]
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> ---
> >>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  7 ++++--
> >>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h    | 23 +++++++++++------=
--
> >>   .../gpu/drm/amd/pm/legacy-dpm/sislands_smc.h  | 15 ++++++++----
> >>   3 files changed, 29 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/=
drm/amd/pm/legacy-dpm/si_dpm.c
> >> index a87dcf0974bc..2c9d473d122f 100644
> >> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> >> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> >> @@ -5234,7 +5234,8 @@ static int si_init_smc_table(struct amdgpu_devic=
e *adev)
> >>       table->driverState.flags =3D table->initialState.flags;
> >>       table->driverState.levelCount =3D table->initialState.levelCount=
;
> >> -    table->driverState.levels[0] =3D table->initialState.level;
> >> +    container_of(&table->driverState, SISLANDS_SMC_SWSTATE, __hdr)->l=
evels[0] =3D
> >> +                                table->initialState.level;
> >>       ret =3D si_do_program_memory_timing_parameters(adev, amdgpu_boot=
_state,
> >>                                SISLANDS_INITIAL_STATE_ARB_INDEX);
> >> @@ -5755,7 +5756,9 @@ static int si_upload_sw_state(struct amdgpu_devi=
ce *adev,
> >>       int ret;
> >>       u32 address =3D si_pi->state_table_start +
> >>           offsetof(SISLANDS_SMC_STATETABLE, driverState);
> >> -    SISLANDS_SMC_SWSTATE *smc_state =3D &si_pi->smc_statetable.driver=
State;
> >> +    SISLANDS_SMC_SWSTATE *smc_state =3D
> >> +        container_of(&si_pi->smc_statetable.driverState,
> >> +                 SISLANDS_SMC_SWSTATE, __hdr);
> >>       size_t state_size =3D struct_size(smc_state, levels,
> >>                       new_state->performance_level_count);
> >>       memset(smc_state, 0, state_size);
> >> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h b/drivers/gpu/=
drm/amd/pm/legacy-dpm/si_dpm.h
> >> index 11cb7874a6bb..62530f89ebdf 100644
> >> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
> >> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.h
> >> @@ -784,12 +784,17 @@ typedef struct NISLANDS_SMC_HW_PERFORMANCE_LEVEL=
 NISLANDS_SMC_HW_PERFORMANCE_LEV
> >>   struct NISLANDS_SMC_SWSTATE
> >>   {
> >> -    uint8_t                             flags;
> >> -    uint8_t                             levelCount;
> >> -    uint8_t                             padding2;
> >> -    uint8_t                             padding3;
> >> -    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
> >> +    /* New members MUST be added within the struct_group() macro belo=
w. */
> >> +    struct_group_tagged(NISLANDS_SMC_SWSTATE_HDR, __hdr,
> >> +        uint8_t                             flags;
> >> +        uint8_t                             levelCount;
> >> +        uint8_t                             padding2;
> >> +        uint8_t                             padding3;
> >> +    );
> >> +    NISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
> >>   };
> >> +static_assert(offsetof(struct NISLANDS_SMC_SWSTATE, levels) =3D=3D si=
zeof(struct NISLANDS_SMC_SWSTATE_HDR),
> >> +          "struct member likely outside of struct_group_tagged()");
> >>   typedef struct NISLANDS_SMC_SWSTATE NISLANDS_SMC_SWSTATE;
> >> @@ -813,10 +818,10 @@ struct NISLANDS_SMC_STATETABLE
> >>       uint32_t                            lowSMIO[NISLANDS_MAX_NO_VREG=
_STEPS];
> >>       NISLANDS_SMC_VOLTAGEMASKTABLE       voltageMaskTable;
> >>       PP_NIslands_DPM2Parameters          dpm2Params;
> >> -    NISLANDS_SMC_SWSTATE                initialState;
> >> -    NISLANDS_SMC_SWSTATE                ACPIState;
> >> -    NISLANDS_SMC_SWSTATE                ULVState;
> >> -    NISLANDS_SMC_SWSTATE                driverState;
> >> +    struct NISLANDS_SMC_SWSTATE_HDR        initialState;
> >> +    struct NISLANDS_SMC_SWSTATE_HDR        ACPIState;
> >> +    struct NISLANDS_SMC_SWSTATE_HDR        ULVState;
> >> +    struct NISLANDS_SMC_SWSTATE_HDR        driverState;
> >>       NISLANDS_SMC_HW_PERFORMANCE_LEVEL   dpmLevels[NISLANDS_MAX_SMC_P=
ERFORMANCE_LEVELS_PER_SWSTATE - 1];
> >>   };
> >> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h b/driver=
s/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> >> index 90ec411c5029..1711e3e35e80 100644
> >> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> >> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/sislands_smc.h
> >> @@ -172,12 +172,17 @@ struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL {
> >>   typedef struct SISLANDS_SMC_HW_PERFORMANCE_LEVEL SISLANDS_SMC_HW_PER=
FORMANCE_LEVEL;
> >>   struct SISLANDS_SMC_SWSTATE {
> >> -    uint8_t                             flags;
> >> -    uint8_t                             levelCount;
> >> -    uint8_t                             padding2;
> >> -    uint8_t                             padding3;
> >> +    /* New members MUST be added within the struct_group() macro belo=
w. */
> >> +    struct_group_tagged(SISLANDS_SMC_SWSTATE_HDR, __hdr,
> >> +        uint8_t                             flags;
> >> +        uint8_t                             levelCount;
> >> +        uint8_t                             padding2;
> >> +        uint8_t                             padding3;
> >> +    );
> >>       SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
> >>   };
> >> +static_assert(offsetof(struct SISLANDS_SMC_SWSTATE, levels) =3D=3D si=
zeof(struct SISLANDS_SMC_SWSTATE_HDR),
> >> +          "struct member likely outside of struct_group_tagged()");
> >>   typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
> >> @@ -215,7 +220,7 @@ struct SISLANDS_SMC_STATETABLE {
> >>       struct SISLANDS_SMC_SWSTATE_SINGLE    initialState;
> >>       struct SISLANDS_SMC_SWSTATE_SINGLE    ACPIState;
> >>       struct SISLANDS_SMC_SWSTATE_SINGLE    ULVState;
> >> -    SISLANDS_SMC_SWSTATE            driverState;
> >> +    struct SISLANDS_SMC_SWSTATE_HDR        driverState;
> >>       SISLANDS_SMC_HW_PERFORMANCE_LEVEL    dpmLevels[SISLANDS_MAX_SMC_=
PERFORMANCE_LEVELS_PER_SWSTATE];
> >>   };
> >
>
