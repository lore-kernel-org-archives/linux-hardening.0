Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C936729C
	for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789832101; cv=none; b=DraOZEO2HaMNlVTDbnqSahdHVy1xuKdkppRt4xc7ksT4/MsL4VX810MroFy/Ld+oze3tB+gS7e4E19kYRLvr0SyMwOlbTSVv9yVHU+N/3KkcOw1BQS2ZONREkESGfn1UiLdPU8ycTRmeByGzFb2ZqsH7FrrjItAf6Zck59lh4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789832101; c=relaxed/simple;
	bh=r8uZ6cbMPFCpPEsjD4R5PSBJwGAVgcajYlWqKZANcWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b19V+49q5SQ9kIg9ZEG7ydDJSzIgLir61pjznhrYwPGyDWYqqVwKxXfQ1N3vaIAj7xaFPo3CFKIjMpX9FR61d5f81GdbU/jrkjBsomN980X/FgDh8U4GMnlJ6YhY9ei4r3xE1x37YicRTeJkE6cJ46GK5g0XL0afa/7VVaB61rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEAx5wbF; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEAx5wbF"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso8168935e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789832097; x=1790436897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rnmxa+I/y/WovjQwepcy66tvkG9fBv5IMAXIabUtoDI=;
        b=dEAx5wbF4JzZfer7o16byIqDW1qOtDJkVca4zWjuC/OFkdz26pbFLEjQt6f2qcx3kq
         q5pGJWHqcVefVu7kIxJ/8nEPdVJyw+fIJO+tucZDvDehyhNvJDIATRRbg3ylsQmi4eAQ
         I16vG4a/6nNAP+oIx+hMM6w0/wYtu/heTmD9FJurBzAmdB/R2SWEBLqL/FRZ4mp2QAGd
         gfITX6ZN0RBixqGNBQylM2/N7RTzKeCnz6f4LM0DMqog99vDQ/X/zNohB0vgJILhUO4A
         3dLXigmV2eTE6jGKZOLoOW0o+8dklAUQ8HAgGdStpDhz5MoyjJhHiJjt16wHs/82APNz
         bNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789832097; x=1790436897;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rnmxa+I/y/WovjQwepcy66tvkG9fBv5IMAXIabUtoDI=;
        b=VrLQJWvNwaRz/0z+my7umeoyezJEQKlSFatjuAAUuwtCbvNH1LjpzTKuHp61PZQKSA
         DiWq0nTP8CZWAfer53CGVQLytn/GYluGOBJfufAwx/7Q6Ef/srFOCN4MlpCnLAlCSqPc
         EsaJ5dmyXw83mgJFsb3r8ahNvPVMr6xwAeRb02i2vg7Dxn9nRZsSvGRY+RBx2J6utFGf
         YtvfeCZN5zivclUqUIISQexBhVI0ZTp22aNp9bAw2oOMctXYkVc2kwH5F6qv4al5FhZS
         CbFqidlLtA7650eJa2hGByo/vXizqkFMBQZunu7CkWV3Hv72BRQrobqSEp9wK9JUg1H+
         f9/A==
X-Forwarded-Encrypted: i=1; AKwUvBwv2HPuG/K/wlKt52opGrRPdmYNCXlYj49lYgpnZxruUmhQCwgSAcotZku7IDa0F+CKn3YkZJyNEYFGX+aJMb4=@vger.kernel.org
X-Gm-Message-State: AFuF++kKS4yDOD9Nh0vnjYgz3nCXeBcBhQAPlXLXuUqZUycZAUg1LdJJ
	fGRxYOa5a+aaIrHQhWQQ+yuT9JdcoLJs5rGWjoWbNY/ICUCe30Wm7uBE
X-Gm-Gg: AYBFou1XqCFTIlnP8kQfNIMezGxFGNuna8t4WZgV7qkKeTcHVraFVtExLbf0CPmSe8F
	6Djh/v13wj95EpGwX605T8x9zJyr7rbvdXptF5BPd69q3ApRwgF9OEWQa8SST8TyDtlg7uzjzSN
	4tyo6pAG2K2KbhILzBsqpPDGbcg9je7HSZDf4ltcgJQMHkPeUsfH1fIhxM/aYuJ0VVmLT4IyWKX
	W1c1w0cl11jWjd9oT1HC0Y24x9f/9QLqVPT4NFZKNQPaGoRPHk/L2pUEbDYgw5KApS2nJXHE4eY
	hGugyHr/MWKWpl3SB0tSJ6hwbtiVXfuRrElv8aJVT+r/nIB15POsj/Bhkki8CCrU3oyJWeoJfJ4
	U4cBFagM9iHpkxCixnTLVc2VS1L9nY6X5AFJKdsQIv39ptaZCKbuZ9k9NtRF1CVySu2AA2xaBz5
	du81FY2f6OhZvu7YE4diC6/k7uLdZGrSPgmFSlN4Ss4l/0xUf2oAFwFbc+eTWD8MawQDY0nju6R
	0owEHSKtv+FGBnfIZiYU5/E6DyNkbA09VEIBrCR4TcgnRG2FJzj2LVsPbVRmGQU0ztp3wLFrF3U
	Cg==
X-Received: by 2002:a05:600c:3588:b0:49c:d26a:cf70 with SMTP id 5b1f17b1804b1-49fcc3772bamr70227405e9.15.1789832096898;
        Sat, 19 Sep 2026 08:34:56 -0700 (PDT)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724422790sm7066857f8f.5.2026.09.19.08.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 08:34:56 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <cdebaad4-00c2-4b80-b688-0f5a723d6009@gmail.com>
Date: Sat, 19 Sep 2026 16:34:54 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] kconfig: Add "def_string", "def_int" and "def_hex"
To: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Jones <andrew.jones@linux.dev>, linux-kbuild@vger.kernel.org,
 linux-doc@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 Nauman Sabir <officialnaumansabir@gmail.com>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Matthew Maurer <mmaurer@google.com>, Graham Roff <grahamr@qti.qualcomm.com>,
 Miguel Ojeda <ojeda@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, conor.dooley@microchip.com
References: <20260919005923.i.879-kees@kernel.org>
 <20260919005929.4077729-1-kees@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260919005929.4077729-1-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kees,

On 9/19/26 01:59, Kees Cook wrote:
> Kconfig has offered "def_bool" and "def_tristate" as a shorthand for a
> type definition plus a default since before the git era, but has never
> offered the equivalent for the other three types. Conor Dooley ran into

CC'd Conor.

> this gap[1] when fixing a symbol that had been given the wrong type:
> 
>   Unfortunately, there is no such thing as "def_string", but in this
>   case we can use "default" to propagate the value of ...
> 
> Nothing in the grammar requires the restriction. The rule that consumes
> a default is already type agnostic. Add the three missing types. No
> changes are needed to existing diagnostics. E.g. declaring a symbol
> "bool" and then assigning it with "def_string" still reports
> 
>   warning: ignoring type redefinition of 'CONFLICT' from 'bool' to 'string'

I like this change, as the Kconfiglib implementation of Kconfig used by
Zephyr already extended the language to add this [1], so it unifies the
ecosystem a bit.

But... I must say that I think def_bool / def_tristate is possibly the
worst part of the language. First, because the condition only applies
to a part of the statement (unintuitive). For example:

  def_bool 'y' if X

the X condition here only applies to the value of y, but not to the type
declaration of bool. Besides hurting readability, I can imagine a user
making a mistake by attempting something like this:

  def_bool 'y' if X
  def_tristate 'y' if !X

thinking that they're making the type conditional. Of course, the
interpreter warns if this is attempted, so you won't actually find any
of these in the tree.

The second problem, is that since the order of defaults matters and
conditions can shadow each other, def_<type> makes it harder for users
to get defaults right. In the past, I've seen several config options
with bugged defaults due to 'default' + 'def_<type>' [2][3][4].

Yet, all this adds for users, is avoiding typing four letters: "ault".

But since this def_bool / def_tristate is already used *everywhere*
throughout the tree, I don't think it's realistic to remove it, and
would be better to support the other types.

> 
> Added tests for the types.
> 
> Build tested ARCH=x86_64 with GCC 16.2.0. Tests pass with "make testconfig".
> 
> Link: https://lore.kernel.org/all/20230111104848.2088516-1-conor.dooley@microchip.com/ [1]
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>

Tested-by: Julian Braha <julianbraha@gmail.com>
Reviewed-by: Julian Braha <julianbraha@gmail.com>

> ---
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nsc@kernel.org>
> Cc: Julian Braha <julianbraha@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andrew Jones <andrew.jones@linux.dev>
> Cc: <linux-kbuild@vger.kernel.org>
> Cc: <linux-doc@vger.kernel.org>
> ---
>  scripts/kconfig/tests/def_type/Kconfig        | 28 +++++++++++++++++++
>  scripts/kconfig/tests/def_type/guard_n.config |  1 +
>  scripts/kconfig/tests/def_type/guard_y.config |  1 +
>  scripts/kconfig/tests/def_type/__init__.py    | 18 ++++++++++++
>  .../kconfig/tests/def_type/expected_guard_n   |  9 ++++++
>  .../kconfig/tests/def_type/expected_guard_y   | 11 ++++++++
>  scripts/kconfig/kconfig-sym-check.pl          |  2 +-
>  scripts/kconfig/lexer.l                       |  3 ++
>  scripts/kconfig/parser.y                      |  6 ++++
>  Documentation/kbuild/kconfig-language.rst     | 13 ++++++++-
>  10 files changed, 90 insertions(+), 2 deletions(-)
>  create mode 100644 scripts/kconfig/tests/def_type/Kconfig
>  create mode 100644 scripts/kconfig/tests/def_type/guard_n.config
>  create mode 100644 scripts/kconfig/tests/def_type/guard_y.config
>  create mode 100644 scripts/kconfig/tests/def_type/__init__.py
>  create mode 100644 scripts/kconfig/tests/def_type/expected_guard_n
>  create mode 100644 scripts/kconfig/tests/def_type/expected_guard_y
> 
> diff --git a/scripts/kconfig/tests/def_type/Kconfig b/scripts/kconfig/tests/def_type/Kconfig
> new file mode 100644
> index 000000000000..fbee37a63179
> --- /dev/null
> +++ b/scripts/kconfig/tests/def_type/Kconfig
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# The def_<type> shorthands: a type definition plus a default value.
> +
> +config MODULES
> +	bool "Enable loadable module support"
> +	modules
> +	default y
> +
> +config GUARD
> +	bool "Guard symbol"
> +
> +config DEF_BOOL
> +	def_bool GUARD
> +
> +config DEF_TRISTATE
> +	def_tristate m if GUARD
> +
> +config DEF_STRING
> +	def_string "guarded" if GUARD
> +	default "fallback"
> +
> +config DEF_INT
> +	def_int 64 if GUARD
> +	default 32
> +
> +config DEF_HEX
> +	def_hex 0xdead if GUARD
> +	default 0x0
> diff --git a/scripts/kconfig/tests/def_type/guard_n.config b/scripts/kconfig/tests/def_type/guard_n.config
> new file mode 100644
> index 000000000000..ed9ad6c1a2d4
> --- /dev/null
> +++ b/scripts/kconfig/tests/def_type/guard_n.config
> @@ -0,0 +1 @@
> +# CONFIG_GUARD is not set
> diff --git a/scripts/kconfig/tests/def_type/guard_y.config b/scripts/kconfig/tests/def_type/guard_y.config
> new file mode 100644
> index 000000000000..afe35b084542
> --- /dev/null
> +++ b/scripts/kconfig/tests/def_type/guard_y.config
> @@ -0,0 +1 @@
> +CONFIG_GUARD=y
> diff --git a/scripts/kconfig/tests/def_type/__init__.py b/scripts/kconfig/tests/def_type/__init__.py
> new file mode 100644
> index 000000000000..1ebaf5da07c8
> --- /dev/null
> +++ b/scripts/kconfig/tests/def_type/__init__.py
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +"""
> +Set a symbol's type and its default value in one line.
> +
> +"def_bool", "def_tristate", "def_string", "def_int" and "def_hex" are
> +shorthand for a type definition plus a "default" property.  Check that
> +each one sets the type, and that an "if" on the shorthand does not
> +disturb the usual default cascade: the shorthand is only the first arm
> +of the list, so a later "default" still applies when its condition is
> +not met.
> +"""
> +
> +def test(conf):
> +    assert conf.olddefconfig(dot_config='guard_y.config') == 0
> +    assert conf.config_matches('expected_guard_y')
> +
> +    assert conf.olddefconfig(dot_config='guard_n.config') == 0
> +    assert conf.config_matches('expected_guard_n')
> diff --git a/scripts/kconfig/tests/def_type/expected_guard_n b/scripts/kconfig/tests/def_type/expected_guard_n
> new file mode 100644
> index 000000000000..14719720a8b9
> --- /dev/null
> +++ b/scripts/kconfig/tests/def_type/expected_guard_n
> @@ -0,0 +1,9 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Main menu
> +#
> +CONFIG_MODULES=y
> +# CONFIG_GUARD is not set
> +CONFIG_DEF_STRING="fallback"
> +CONFIG_DEF_INT=32
> +CONFIG_DEF_HEX=0x0
> diff --git a/scripts/kconfig/tests/def_type/expected_guard_y b/scripts/kconfig/tests/def_type/expected_guard_y
> new file mode 100644
> index 000000000000..b2844072d0b8
> --- /dev/null
> +++ b/scripts/kconfig/tests/def_type/expected_guard_y
> @@ -0,0 +1,11 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Main menu
> +#
> +CONFIG_MODULES=y
> +CONFIG_GUARD=y
> +CONFIG_DEF_BOOL=y
> +CONFIG_DEF_TRISTATE=m
> +CONFIG_DEF_STRING="guarded"
> +CONFIG_DEF_INT=64
> +CONFIG_DEF_HEX=0xdead

The added test is great.

> diff --git a/scripts/kconfig/kconfig-sym-check.pl b/scripts/kconfig/kconfig-sym-check.pl
> index daa5285fdefc..c8dd07f8b27c 100755
> --- a/scripts/kconfig/kconfig-sym-check.pl
> +++ b/scripts/kconfig/kconfig-sym-check.pl
> @@ -90,7 +90,7 @@ foreach my $file (@files) {
>  			next;
>  		}
>  
> -		if (/^\s*(default|def_bool|def_tristate|select|depends\s+on|imply|visible\s+if|range|if|bool|tristate|int|hex|string|prompt)\s+(.+)\s*$/) {
> +		if (/^\s*(default|def_bool|def_tristate|def_string|def_int|def_hex|select|depends\s+on|imply|visible\s+if|range|if|bool|tristate|int|hex|string|prompt)\s+(.+)\s*$/) {
>  			my $s = $2;
>  			$s =~ s/"(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*'//g;
>  			$s =~ s/#.*//;
> diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
> index a6155422b4a6..1fa521199d4a 100644
> --- a/scripts/kconfig/lexer.l
> +++ b/scripts/kconfig/lexer.l
> @@ -105,6 +105,9 @@ n	[A-Za-z0-9_-]
>  "comment"		return T_COMMENT;
>  "config"		return T_CONFIG;
>  "def_bool"		return T_DEF_BOOL;
> +"def_hex"		return T_DEF_HEX;
> +"def_int"		return T_DEF_INT;
> +"def_string"		return T_DEF_STRING;
>  "def_tristate"		return T_DEF_TRISTATE;
>  "default"		return T_DEFAULT;
>  "depends"		return T_DEPENDS;
> diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
> index 5fb6f07b6ad2..2174baf2b3fd 100644
> --- a/scripts/kconfig/parser.y
> +++ b/scripts/kconfig/parser.y
> @@ -53,6 +53,9 @@ struct menu *current_menu, *current_entry, *current_choice;
>  %token T_CONFIG
>  %token T_DEFAULT
>  %token T_DEF_BOOL
> +%token T_DEF_HEX
> +%token T_DEF_INT
> +%token T_DEF_STRING
>  %token T_DEF_TRISTATE
>  %token T_DEPENDS
>  %token T_ENDCHOICE
> @@ -309,6 +312,9 @@ type:
>  default:
>  	  T_DEFAULT		{ $$ = S_UNKNOWN; }
>  	| T_DEF_BOOL		{ $$ = S_BOOLEAN; }
> +	| T_DEF_HEX		{ $$ = S_HEX; }
> +	| T_DEF_INT		{ $$ = S_INT; }
> +	| T_DEF_STRING		{ $$ = S_STRING; }
>  	| T_DEF_TRISTATE	{ $$ = S_TRISTATE; }
>  
>  /* if entry */
> diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
> index d9338407c1c6..00402d43e0dc 100644
> --- a/Documentation/kbuild/kconfig-language.rst
> +++ b/Documentation/kbuild/kconfig-language.rst
> @@ -113,11 +113,22 @@ applicable everywhere (see syntax).
>  
>  - type definition + default value::
>  
> -	"def_bool"/"def_tristate" <expr> ["if" <expr>]
> +	"def_bool" <expr> ["if" <expr>]
> +	"def_tristate" <expr> ["if" <expr>]
> +	"def_string" <expr> ["if" <expr>]
> +	"def_int" <expr> ["if" <expr>]
> +	"def_hex" <expr> ["if" <expr>]
>  
>    This is a shorthand notation for a type definition plus a value.
>    Optionally dependencies for this default value can be added with "if".
>  
> +  The shorthand supplies the type once, and is otherwise an ordinary
> +  default: it is the first entry of the list described above, so any
> +  further "default" entries still apply when its "if" is not met. Since
> +  that leaves the type definition inside one arm of a list, spelling the
> +  type out on its own line reads better for a symbol with several
> +  defaults.
> +
>  - dependencies: "depends on" <expr> ["if" <expr>]
>  
>    This defines a dependency for this menu entry. If multiple

[1] https://docs.zephyrproject.org/latest/build/kconfig/extensions.html
[2]
https://lore.kernel.org/all/20260405161545.161006-1-julianbraha@gmail.com/
[3]
https://lore.kernel.org/all/20260322220125.1380776-1-julianbraha@gmail.com/
[4]
https://lore.kernel.org/linux-s390/20260512174336.907050-1-julianbraha@gmail.com/

- Julian Braha
