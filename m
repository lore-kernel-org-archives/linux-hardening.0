Received: from b224-18.smtp-out.eu-central-1.amazonses.com (b224-18.smtp-out.eu-central-1.amazonses.com [69.169.224.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A0163;
	Sun, 23 Mar 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.169.224.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742733766; cv=none; b=diOQkqBk1wZA14IaLOuuyvqlcaZF04MRTpkjRLRC2gtgMlh36+pLJmh97qEEDGhYmIkKLnfeFPwO99nWXxfRZu5kPHeS8+5iGvUugruTD3EucLjWKEM3IiKTQHrE3hhymqH/lPHcgBMWbRTIcwMKhU0vqjHriwxbVxZDuo1Q9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742733766; c=relaxed/simple;
	bh=LrAaxJ3uGP1EpZGbKJtAW4zP/hxp5wOoExzud2mX2Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF2ctyqG/V52WRvKHXArxe/H63mLgNuX2hbb3xfcri9O9TqQn/JHEErLwnc9rrPS5DsQ8iqN8DVG4FbjJnB3NEXEIi3vjhV4LX68+iGy6L12h8rCMq7W08Z99q0VgFVoGqlBTV+ediCqfBUWlPrrfLUfmtAjdFDuu+Bq4OzGSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=mail.riscv-rocks.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=DMfq/V9f; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=HEiP/ePy; arc=none smtp.client-ip=69.169.224.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="DMfq/V9f";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HEiP/ePy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=2kaovp6zxy5nzp5wqunvdq5vkiqbeqln; d=riscv-rocks.de; t=1742733761;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
	bh=LrAaxJ3uGP1EpZGbKJtAW4zP/hxp5wOoExzud2mX2Xo=;
	b=DMfq/V9fggKoRozqNK4DYV7YAuDOyzhhtFwgJcX9uCO2VCPwJuWRjq6liTzJBym6
	o0LQ72CVC06C8Eeog6UBTtC6B7LrQzrg5ODK/57A6blK9PPw0N598FM0xPUynMM30Xp
	/j//X+/fDYtyvCMKRFRhzNNhBDVEMWY/Gy6kFqiBeLMHQL44QtSecXR5spxN0PqJ5Zn
	AbC9FmUMsAw0yN6X4gJXv0/hPHuTh362F41bypRM+lSOalyRI3jPIP6eDGUlyMnIZXI
	MgxJBpQ1jlc8zVvKhezGdC9VUBFCg5SnI5/ls9VHD4/XXtvESNJ4pBHsxcuy7lZXZCA
	gBoQ8LikmA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=54ecsf3zk7z4mwxwwox7z7bg6e5gwjsz; d=amazonses.com; t=1742733761;
	h=Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Feedback-ID;
	bh=LrAaxJ3uGP1EpZGbKJtAW4zP/hxp5wOoExzud2mX2Xo=;
	b=HEiP/ePyv/5qHXZiNwlxklL8mfQ5s8IY29RDfjipiHPgYTUJMLJh8BhI5EwcD4nf
	V/qiL4r2Ab4pNWZ8VeNq9DDLZaI8L4UHpFCoWFFnw5RAvWAwwjFo6yXPiI4eH2Vwut7
	N8CHcUTn55CWd+ENrEg3OIGoTFIay+AMHGP0X0Xs=
Date: Sun, 23 Mar 2025 12:42:41 +0000
From: Damian Tometzki <damian@riscv-rocks.de>
To: Kees Cook <kees@kernel.org>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Zhi Wang <zhi.wang.linux@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Add __nonstring annotations for
 unterminated strings
Message-ID: <01070195c306db7f-9f28efdd-9456-4db3-b6c6-343298bd571b-000000@eu-central-1.amazonses.com>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: Kees Cook <kees@kernel.org>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250310222355.work.417-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310222355.work.417-kees@kernel.org>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 42 (Adams) (Kernel 6.14.0-rc7)
Organization: Linux hacker
Feedback-ID: ::1.eu-central-1.yMcBPu/jK26Vj3HVmCFyFk75QMsS8V3QY5HbXP/Qrys=:AmazonSES
X-SES-Outgoing: 2025.03.23-69.169.224.18

On Mon, 10. Mar 15:23, Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Zhi Wang <zhi.wang.linux@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: intel-gvt-dev@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  drivers/gpu/drm/i915/gvt/opregion.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> index 509f9ccae3a9..f701638d3145 100644
> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> @@ -43,7 +43,7 @@
>  #define DEVICE_TYPE_EFP4   0x10
>  
>  struct opregion_header {
> -	u8 signature[16];
> +	u8 signature[16] __nonstring;
>  	u32 size;
>  	u32 opregion_ver;
>  	u8 bios_ver[32];
> @@ -222,7 +222,7 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
>  	u8 *buf;
>  	struct opregion_header *header;
>  	struct vbt v;
> -	const char opregion_signature[16] = OPREGION_SIGNATURE;
> +	const char opregion_signature[16] __nonstring = OPREGION_SIGNATURE;
>  
>  	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
>  	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
> -- 
> 2.34.1
> 
Hello together,

it doesnt resolve the build issue with gcc15 gcc (GCC) 15.0.1 20250228

CC [M]  drivers/gpu/drm/i915/gvt/scheduler.o
/home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c: In function ‘intel_vgpu_init_opregion’:
/home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c:35:28: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   35 | #define OPREGION_SIGNATURE "IntelGraphicsMem"
      |                            ^~~~~~~~~~~~~~~~~~
/home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c:225:57: note: in expansion of macro ‘OPREGION_SIGNATURE’
  225 |         const char opregion_signature[16] __nonstring = OPREGION_SIGNATURE;
      |                                                         ^~~~~~~~~~~~~~~~~~
  CC [M]  drivers/gpu/drm/i915/gvt/trace_points.o
cc1: all warnings being treated as errors
make[7]: *** [/home/damian/kernel/linux/scripts/Makefile.build:207: drivers/gpu/drm/i915/gvt/opregion.o] Error 1
make[7]: *** Waiting for unfinished jobs....
  CC [M]  drivers/gpu/drm/i915/gvt/vgpu.o
make[6]: *** [/home/damian/kernel/linux/scripts/Makefile.build:465: drivers/gpu/drm/i915] Error 2
make[5]: *** [/home/damian/kernel/linux/s


-- 
VG
Damian Tometzki
