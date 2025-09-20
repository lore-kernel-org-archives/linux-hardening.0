Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351C2D1900
	for <linux-hardening@vger.kernel.org>; Sat, 20 Sep 2025 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400206; cv=none; b=ibtkFVxYIynSatRgX0JBPnxJOFHOM6Y0WIOetADXUhGUJkhqTS/FTuLcvLQoY+ZbpzuWnWa6GdYrsCsiCwxdKjHTVId6GIZ1Qo5RITdr0MAXv9Bhhy4153+KbUA3hXi32YhPtr0wIXGcnnnrWgz90ROOm8f7jBbIZYG7SS9stVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400206; c=relaxed/simple;
	bh=Gt83LjrXisW7PYm44qYXy/RI7yU0EyP0qvFrTG78OVg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=t5ng2ZJPfo4S3qNtTk1Me2uY8a3IaIrYhS0j/0IecB0SB8nq2UYrmGXqeKlO6dSOMbnpbTS0vsrwlzwLS5HEPHu+hwTi86h1eQeB9TiMvEOxQR1RfL0J8aJaBm3sTByhe4EdYYhLsi9xGJqhHlT5OUjT7AbDKZyNTE4BWofLS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUlT4hPu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUlT4hPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD4CC4CEEB;
	Sat, 20 Sep 2025 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758400206;
	bh=Gt83LjrXisW7PYm44qYXy/RI7yU0EyP0qvFrTG78OVg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=NUlT4hPuhhG7r/gqO0ie++l5ePbC6CJj424ILNurfQFX9oUvJGk7l5QkVO/T42WJ5
	 GmjSDEJ5znYl9cHPC9HVx+Et6Q5ZLSLXooE7Xl6VubV7n+1+TFB8UcX5dpuN8K56uG
	 6E7sOZI7I/idAvin01021VL7qMCGmiY9fr/79D0FCSgtRSFPW+H3xIlqfoEzzsVQ7A
	 i+8gpHxXSXkHo1AljqD/3QtNpz+HBNQ198oMWwA9IwAsfM7rGBTU5agmRrPEvwJPN5
	 sO/3vDlCQhG4e+VuvM1n/kIh0cCH+9wnMMjdVMu2i3XFM/DB08MOLoEFlLX7yRgul5
	 YY5nhUV7e9/TQ==
Date: Sat, 20 Sep 2025 13:30:02 -0700
From: Kees Cook <kees@kernel.org>
To: Christopher Fore <csfore@posteo.net>
CC: linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scripts/gcc-plugins: Remove TODO flag
User-Agent: K-9 Mail for Android
In-Reply-To: <20250920195127.22425-1-csfore@posteo.net>
References: <20250920195127.22425-1-csfore@posteo.net>
Message-ID: <8572D146-4DB9-46A6-9A0C-C155F48F56F2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 20, 2025 12:51:51 PM PDT, Christopher Fore <csfore@posteo=2En=
et> wrote:
>TODO_verify_il was removed by GCC at
>9739ae9384dd7cd3bb1c7683d6b80b7a9116eaf8
>
>Direct link to GCC commit:
>https://gcc=2Egnu=2Eorg/git/?p=3Dgcc=2Egit;a=3Dcommit;h=3D9739ae9384dd7cd=
3bb1c7683d6b80b7a9116eaf8
>
>Signed-off-by: Christopher Fore <csfore@posteo=2Enet>
>---
> scripts/gcc-plugins/gcc-common=2Eh            | 5 -----
> scripts/gcc-plugins/latent_entropy_plugin=2Ec | 2 +-
> scripts/gcc-plugins/stackleak_plugin=2Ec      | 3 +--
> 3 files changed, 2 insertions(+), 8 deletions(-)
>
>diff --git a/scripts/gcc-plugins/gcc-common=2Eh b/scripts/gcc-plugins/gcc=
-common=2Eh
>index 6cb6d1051815=2E=2Ecedc655f4741 100644
>--- a/scripts/gcc-plugins/gcc-common=2Eh
>+++ b/scripts/gcc-plugins/gcc-common=2Eh
>@@ -173,11 +173,6 @@ static inline opt_pass *get_pass_for_id(int id)
> 	return g->get_passes()->get_pass_for_id(id);
> }
>=20
>-#define TODO_verify_ssa TODO_verify_il
>-#define TODO_verify_flow TODO_verify_il
>-#define TODO_verify_stmts TODO_verify_il
>-#define TODO_verify_rtl_sharing TODO_verify_il
>-
> #define INSN_DELETED_P(insn) (insn)->deleted()
>=20
> static inline const char *get_decl_section_name(const_tree decl)
>diff --git a/scripts/gcc-plugins/latent_entropy_plugin=2Ec b/scripts/gcc-=
plugins/latent_entropy_plugin=2Ec
>index ff0b192be91f=2E=2E065e1fe58f75 100644
>--- a/scripts/gcc-plugins/latent_entropy_plugin=2Ec
>+++ b/scripts/gcc-plugins/latent_entropy_plugin=2Ec
>@@ -564,7 +564,7 @@ static void latent_entropy_start_unit(void *gcc_data =
__unused,
>=20
> #define PASS_NAME latent_entropy
> #define PROPERTIES_REQUIRED PROP_gimple_leh | PROP_cfg
>-#define TODO_FLAGS_FINISH TODO_verify_ssa | TODO_verify_stmts | TODO_dum=
p_func \
>+#define TODO_FLAGS_FINISH TODO_dump_func \
> 	| TODO_update_ssa

It looks like you've replaced verify_ssa with update_ssa? Is this a valid =
option for all Linux supported GCC versions? (And is this the correct repla=
cement?)

-Kees

> #include "gcc-generate-gimple-pass=2Eh"
>=20
>diff --git a/scripts/gcc-plugins/stackleak_plugin=2Ec b/scripts/gcc-plugi=
ns/stackleak_plugin=2Ec
>index e486488c867d=2E=2E6f663bcfda84 100644
>--- a/scripts/gcc-plugins/stackleak_plugin=2Ec
>+++ b/scripts/gcc-plugins/stackleak_plugin=2Ec
>@@ -503,8 +503,7 @@ static bool stackleak_instrument_gate(void)
>=20
> #define PASS_NAME stackleak_instrument
> #define PROPERTIES_REQUIRED PROP_gimple_leh | PROP_cfg
>-#define TODO_FLAGS_START TODO_verify_ssa | TODO_verify_flow | TODO_verif=
y_stmts
>-#define TODO_FLAGS_FINISH TODO_verify_ssa | TODO_verify_stmts | TODO_dum=
p_func \
>+#define TODO_FLAGS_FINISH TODO_dump_func \
> 			| TODO_update_ssa | TODO_rebuild_cgraph_edges
> #include "gcc-generate-gimple-pass=2Eh"
>=20

--=20
Kees Cook
