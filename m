Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D201FFC7B
	for <linux-hardening@vger.kernel.org>; Sat, 20 Sep 2025 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758401537; cv=none; b=S0j8hVLsWd4UCku7DzrA8zQO07v/2ZO3d8eNi4b1cCtynN/qNCd4KDicNijTKAKIztYFXc9dLBiduajOJo9ijU9imgMRO9TYU1UDfNu2zrjm4etUMqEf411ZGKM2yxDDBfjRcm0LFwE16Hi6f2Z2d6bhdEJ7Njbk7DxfrylpmRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758401537; c=relaxed/simple;
	bh=wkFdCshhUQUX/zfjeE1L6OwHIn6NVo2xmLRYUNc4HHQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nJ6Rx9Yks7runh08liZa/5bygAL9H5dAsxbxo4XBRVOK/RqM022Y3J/sTun2259/jqr6/sHKOE4JSc+8clb9JB7SI4hrAMZjKLCTKL5jMXrpTqKNuJYynM2ip0tB/fDUPAitqUqd0xiyg9bdDgf1kfmB+KtxgkUkpZQ3Is06j9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=cIRbD2HU; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="cIRbD2HU"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 839EA240027
	for <linux-hardening@vger.kernel.org>; Sat, 20 Sep 2025 22:52:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1758401532; bh=spIOfQywUzsFWelobcTS9aBd8/AlS5hNyMR+s8ynTXI=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=cIRbD2HUuR2XEPbObrRtZty9ouCmu6hHLKjqwYgw1t+N420RhYnWIWyYVHs/cit7t
	 kA5uKEsc9Qdf6IoB+ys01y71CNmZGa6+rDS0CH82mTV40RXHTVAe8rbwLinylQFF/q
	 Fa/TpB2Qb8pXDjb7LcQCuMpknkV4pw328Y4a2E+19W3WNsKg5oNbtiGte1J1iFqHo5
	 v1QBANtI2Sh0EaNVW3vxR1v4IHrWNQzfWjFYHKPOqsROJsHSAj3datM5FWgU3UtWqJ
	 xyUQ5UWIFLTtWBWjwDl4e03Lnn9ZaEiNsXTFLx84PHG0iExVDXyUtesZzhuGX7PkM8
	 yPMcM7jxT+KHA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cThQ40sNhz6tsf;
	Sat, 20 Sep 2025 22:52:12 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 20 Sep 2025 20:52:12 +0000
From: csfore@posteo.net
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scripts/gcc-plugins: Remove TODO flag
In-Reply-To: <8572D146-4DB9-46A6-9A0C-C155F48F56F2@kernel.org>
References: <20250920195127.22425-1-csfore@posteo.net>
 <8572D146-4DB9-46A6-9A0C-C155F48F56F2@kernel.org>
Message-ID: <452077d24587d0d17272d74d079d8d40@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit



On 2025-09-20 16:30, Kees Cook wrote:
> On September 20, 2025 12:51:51 PM PDT, Christopher Fore
> <csfore@posteo.net> wrote:
>> TODO_verify_il was removed by GCC at
>> 9739ae9384dd7cd3bb1c7683d6b80b7a9116eaf8
>> 
>> Direct link to GCC commit:
>> https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=9739ae9384dd7cd3bb1c7683d6b80b7a9116eaf8
>> 
>> Signed-off-by: Christopher Fore <csfore@posteo.net>
>> ---
>> scripts/gcc-plugins/gcc-common.h            | 5 -----
>> scripts/gcc-plugins/latent_entropy_plugin.c | 2 +-
>> scripts/gcc-plugins/stackleak_plugin.c      | 3 +--
>> 3 files changed, 2 insertions(+), 8 deletions(-)
>> 
>> diff --git a/scripts/gcc-plugins/gcc-common.h 
>> b/scripts/gcc-plugins/gcc-common.h
>> index 6cb6d1051815..cedc655f4741 100644
>> --- a/scripts/gcc-plugins/gcc-common.h
>> +++ b/scripts/gcc-plugins/gcc-common.h
>> @@ -173,11 +173,6 @@ static inline opt_pass *get_pass_for_id(int id)
>> 	return g->get_passes()->get_pass_for_id(id);
>> }
>> 
>> -#define TODO_verify_ssa TODO_verify_il
>> -#define TODO_verify_flow TODO_verify_il
>> -#define TODO_verify_stmts TODO_verify_il
>> -#define TODO_verify_rtl_sharing TODO_verify_il
>> -
>> #define INSN_DELETED_P(insn) (insn)->deleted()
>> 
>> static inline const char *get_decl_section_name(const_tree decl)
>> diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c 
>> b/scripts/gcc-plugins/latent_entropy_plugin.c
>> index ff0b192be91f..065e1fe58f75 100644
>> --- a/scripts/gcc-plugins/latent_entropy_plugin.c
>> +++ b/scripts/gcc-plugins/latent_entropy_plugin.c
>> @@ -564,7 +564,7 @@ static void latent_entropy_start_unit(void 
>> *gcc_data __unused,
>> 
>> #define PASS_NAME latent_entropy
>> #define PROPERTIES_REQUIRED PROP_gimple_leh | PROP_cfg
>> -#define TODO_FLAGS_FINISH TODO_verify_ssa | TODO_verify_stmts | 
>> TODO_dump_func \
>> +#define TODO_FLAGS_FINISH TODO_dump_func \
>> 	| TODO_update_ssa
> 
> It looks like you've replaced verify_ssa with update_ssa? Is this a
> valid option for all Linux supported GCC versions? (And is this the
> correct replacement?)

update_ssa was already there, I think the git diff just misrepresented 
it,
see here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/gcc-plugins/latent_entropy_plugin.c#n568

-Christopher

> -Kees
> 
>> #include "gcc-generate-gimple-pass.h"
>> 
>> diff --git a/scripts/gcc-plugins/stackleak_plugin.c 
>> b/scripts/gcc-plugins/stackleak_plugin.c
>> index e486488c867d..6f663bcfda84 100644
>> --- a/scripts/gcc-plugins/stackleak_plugin.c
>> +++ b/scripts/gcc-plugins/stackleak_plugin.c
>> @@ -503,8 +503,7 @@ static bool stackleak_instrument_gate(void)
>> 
>> #define PASS_NAME stackleak_instrument
>> #define PROPERTIES_REQUIRED PROP_gimple_leh | PROP_cfg
>> -#define TODO_FLAGS_START TODO_verify_ssa | TODO_verify_flow | 
>> TODO_verify_stmts
>> -#define TODO_FLAGS_FINISH TODO_verify_ssa | TODO_verify_stmts | 
>> TODO_dump_func \
>> +#define TODO_FLAGS_FINISH TODO_dump_func \
>> 			| TODO_update_ssa | TODO_rebuild_cgraph_edges
>> #include "gcc-generate-gimple-pass.h"
>> 
