Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764548FF8F
	for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2026 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412271; cv=none; b=VUY5+RTLuLtHiXhobL03PgzSXH3lIEfB51h3JQo8FfiQcofhSkHqCF5FZUyisgMn15wy1ov1fvN20TOCC9Q1ZpRFFgc/8d5NPupco8ruP2neo3TLf6LX6nSvcScLuTfXu69fOeYPMLUtGS4j3aAtMAZ/16pkVMr/YbwkQiivu20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412271; c=relaxed/simple;
	bh=B5bxJ75ibOVKSwhOEeZfwAJ3Mqz1zX+wtBtBYEePKok=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f48N3dHH5eUN8+YjacyPdtIx+JZSldqgat36cXBOluaoAywo4u43K5b96cImdpl1HNVaJXqf4av+Byh0IsbY6TO/4SoRzh3e6BApXeyQSxpxkht4zACQ21juio+wYo9nVxhz/R7L3nHjX2c1px0yDO+wGCATqU2xolWNzj7Tf3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RKRwkP3s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YyvAzJea; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RKRwkP3s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YyvAzJea; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RKRwkP3s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YyvAzJea";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RKRwkP3s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YyvAzJea"
Received: from murzim.nue2.suse.org (unknown [10.168.4.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 598F121C5A;
	Mon, 19 Oct 2026 12:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792412267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t93/jBqrB421Hf4UDELH12wcii4OTqtEnmlgVfQuSJY=;
	b=RKRwkP3sdx+PKQERhMHOcfunqp3eqkzSruwiRag/fAef1vpULlwS14Dcb9KkfEgSt+kek3
	JpMZjZHusuB935wnXdqut+jAc/YfwZU5HhlyBxfly8aaj4ZIk8aijGOkZySSWR/iS01ekb
	wvSVrFqstNf4/1M72ZisisRRjl2rtKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792412267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t93/jBqrB421Hf4UDELH12wcii4OTqtEnmlgVfQuSJY=;
	b=YyvAzJeaE4gd+f5TBNtjzGF7wZa6zsJmtHz09W04HNSqGvV6ZLpbnm1C3lDFj6HqlP/BJm
	WH/Q041BErPoS4CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792412267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t93/jBqrB421Hf4UDELH12wcii4OTqtEnmlgVfQuSJY=;
	b=RKRwkP3sdx+PKQERhMHOcfunqp3eqkzSruwiRag/fAef1vpULlwS14Dcb9KkfEgSt+kek3
	JpMZjZHusuB935wnXdqut+jAc/YfwZU5HhlyBxfly8aaj4ZIk8aijGOkZySSWR/iS01ekb
	wvSVrFqstNf4/1M72ZisisRRjl2rtKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792412267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t93/jBqrB421Hf4UDELH12wcii4OTqtEnmlgVfQuSJY=;
	b=YyvAzJeaE4gd+f5TBNtjzGF7wZa6zsJmtHz09W04HNSqGvV6ZLpbnm1C3lDFj6HqlP/BJm
	WH/Q041BErPoS4CQ==
Date: Mon, 19 Oct 2026 14:17:47 +0200 (CEST)
From: Richard Biener <rguenther@suse.de>
To: Kees Cook <kees@kernel.org>
cc: Richard Biener <richard.guenther@gmail.com>, Jan Hubicka <hubicka@ucw.cz>, 
    Martin Jambor <mjambor@suse.cz>, gcc-patches@gcc.gnu.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipa-icf: Compare access path type sizes without TBAA
 [PR105438]
In-Reply-To: <20261015215136.adec8b-kees@kernel.org>
Message-ID: <o3sqnnq2-0osr-p0oq-0544-o8npp92808n4@fhfr.qr>
References: <20261010050537.i.784-kees@kernel.org> <CAFiYyc2gYAjiKDi+TeC9_qEX+LHa7fSxj42JjRtM6Dbi6Yfidw@mail.gmail.com> <20261015052441.7d2b3c-kees@kernel.org> <39r25275-0488-rq01-55nq-28rs192rp368@fhfr.qr> <76op6r8p-n2p7-r6p8-s541-rs310035q364@fhfr.qr>
 <21s7p869-5267-7nq1-701q-p35771ss56qp@fhfr.qr> <20261015215136.adec8b-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[gmail.com,ucw.cz,suse.cz,gcc.gnu.org,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[murzim.nue2.suse.org:helo,suse.de:email]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, 15 Oct 2026, Kees Cook wrote:

> On Thu, Oct 15, 2026 at 02:04:44PM +0200, Richard Biener wrote:
> > A few kg CO2 later here's a prototype that looks like proper IPA
> > and LTO capable.  Note it still does varpool handling early which
> > I think is OK.  I'm not sure it fits a possible design of different
> > inline from non-inline bodies in more general (GNU extern inline).
> 
> Thanks for this! I gave it a spin. It fixes both PR105438
> testcases and a static-function case (the second patch adds it as
> gcc.dg/ipa/pr105438-5.c), but I ran into a few problems. These are solved
> by the two attached patches that apply on top of yours (on 84348add236):
> 
> 1. Wrong code from IPA-CP. With the alias deferred, IPA-CP runs between
>    the merge decision and the alias. For a local function it can't
>    clone, it narrows the parameter ranges in place to what its own
>    calls pass, so making the other function an alias of it sends it
>    values outside them. 27 of the c-c++-common/torture/
>    builtin-arith-overflow tests abort at -O2 -flto, in C and C++, and
>    this aborts at plain -O2:
> 
>      __attribute__ ((noinline, noclone)) static int
>      f1 (int x, int y) { return x * 7 + y; }
>      __attribute__ ((noinline, noclone)) static int
>      f2 (int x, int y) { return x * 7 + y; }
> 
>      __attribute__ ((noinline)) int t1 (void) { return f1 (2, 3); }
>      __attribute__ ((noinline)) int t2 (void) { return f2 (5, 1); }
> 
>    t2 returns 17. The first patch makes the alias, or redirects the
>    alias's calls, only when the ranges IPA-CP gave the alias's
>    parameters are within the original's.
> 
> 2. Nodes in deferred_merge_aliases can be removed before the list is
>    processed, by the IPA passes between ICF and the inliner. Building
>    the kernel's fs/ext4/super.c crashed in
>    can_remove_if_no_direct_calls_p on a removed node. The first patch
>    adds a cgraph removal hook.
> 
> 3. Your g++.dg/lto/pr105438_0.C passes without your patch: with -r the
>    link is incremental and ICF never runs. The first patch adds
>    -flinker-output=nolto-rel so it'll fail on master and pass with
>    your patch.
> 
> 4. It doesn't look like the optimization summary and the function
>    transform are needed. Under LTO the inliner, and with it the alias
>    creation, runs at WPA, so the aliases reach LTRANS the way ICF's
>    aliases do now, and inline_transform already redirects the call
>    statements. At LTRANS every streamed pair should already be an
>    alias. Reading them also opened an ICF dump at LTRANS, which
>    outputs.exp reports as an extra file (68 new FAILs). The first patch
>    removes both hooks.
> 
> 5. Only the alias path was deferred, so merges that took the
>    wrapper/redirect path still inlined the other body: two global
>    functions (both addresses matter), and everything on targets
>    without symbol aliases. My original two-global-functions case still
>    warned. The second patch handles that path with an inline-only copy:
>    before the calls are redirected, the merged function's direct calls
>    go to a copy of its own body, the wrapper is made as before, and
>    after inlining the calls that weren't inlined go to the original and
>    the copies go away. (I first tried just deferring the wrapper, but
>    then the inliner never inlines the original into the wrapper, which
>    changed code generation all over the testsuite and broke
>    always_inline functions and interrupt handlers.)
> 
> With both patches on yours, check-c and check-c++ on x86_64 match
> master. For the paths without symbol aliases I checked with an
> x86_64-apple-darwin cross compiler. An x86_64 allmodconfig kernel build
> gets the same ICF merge count as master and 7038 bytes more text (of
> 648 MB, so no big deal).
> 
> The kernel case that started this, net/ipv6/ip6_tunnel.c, gets 16
> warnings on m68k from GCC 16 but none from master, where r17-4004's
> check keeps the two functions apart because of their memcpy. The same
> code without the memcpy still gets the 16 warnings from master on
> m68k, and none with your patch, with or without mine on top.
> 
> > > I'm sure this can be completed with some interaction, but our AI
> > > policy makes this questionable.
> 
> These were written with an LLM's help too, especially the build
> orchestration and test creation. It has been explaining the glitches it
> found to me, and that's shaped the code, but I'm hardly a subject matter
> expert on aliases, inlining, and ICF. :P
> 
> But if this direction looks right to you, we don't need my access
> path patch.

So I've thrown the patchset of three back to the LLM for review
with the following result.  At this point I'd expect guidance
from IPA folks.

Richard.



# Code Review: IPA-ICF Deferred Merging Series [PR ipa/105438]

This document reviews the top three commits on `master` in `gcc/`:

1. **`4b2f31435c7`** (`Richard Biener`): *ipa-icf: Defer creating aliases until after inlining [PR105438]*
2. **`4d613c36ad6`** (`Kees Cook`): *ipa-icf: Keep deferred merges from bypassing IPA-CP [PR105438]*
3. **`5e4bdec0d78`** (`Kees Cook`): *ipa-icf: Inline the merged function's own body when it becomes a wrapper [PR105438]*

---

## 1. Executive Summary & Architectural Critique

The series attempts to address **PR ipa/105438**, where Identical Code Folding (IPA-ICF) merges two functions operating on different types (such as different structure layouts or array bounds). When ICF replaces one function with an alias or wrapper of the other prior to inlining, inlining calls to the merged function substitutes the prevailing function's body, whose types do not match the caller's arguments. This leads to bogus `-Warray-bounds` warnings, diagnostic confusion, and potential Type-Based Alias Analysis (TBAA) issues.

Rather than addressing type compatibility during ICF equivalence checking or handling diagnostics during inlining, the series defers ICF alias creation and body deletion until post-inlining (`ipa_inline ()`).

### Fundamental Architectural Breakdown
Deferring the transformation of an early IPA pass across subsequent passes breaks fundamental pipeline invariants in GCC:

```
[pass_ipa_icf] -> [pass_ipa_devirt] -> [pass_ipa_cp] -> [pass_ipa_sra] -> [pass_ipa_fn_summary] -> [pass_ipa_inline]
      |                                                                                                    |
      +--- "Deferred Merges" list (unapplied side-effects) ------------------------------------------------>+
```

1. **Inter-Pass Desynchronization:**
   `pass_ipa_devirt`, `pass_ipa_cp`, `pass_ipa_sra`, and `pass_ipa_fn_summary` run between ICF and inlining. Because the functions are kept separate, each pass analyzes and optimizes `alias` and `original` independently based only on their local call sites:
   - **IPA-CP** narrows parameter ranges in-place or creates specialized clones for one function without the other.
   - **IPA-SRA** splits aggregate parameters or eliminates unused arguments on one function without the other.
   - **IPA-fnsummary** computes separate size, time, and growth summaries.
   Applying ICF merges post-inlining forces two functions together that intermediate passes have diverged, causing invalid GIMPLE, signature mismatches, or silent abandonment of ICF merges.

2. **Heuristic & Metric Distortion:**
   Inlining decisions depend on size summaries and growth estimations. Retaining duplicate bodies throughout inlining distorts the inliner's badness queue and unit growth limits (`estimate_growth`), causing the inliner to evaluate candidates under false assumptions.

3. **Memory Inversion:**
   ICF exists to eliminate duplicate code and conserve memory. By creating version clones (`create_version_clone_with_body`) for wrapper merges and retaining all unmerged bodies through IPA passes, peak compiler memory consumption (RSS) is increased rather than reduced.

4. **LTO Ineffectiveness:**
   At WPA time under LTO, function bodies are not loaded. Clone creation in commit 3 immediately bails out (`if (in_lto_p ... ) return 0;`), redirecting callers directly to the prevailing function before inlining. Consequently, under LTO, PR 105438 remains completely unfixed for wrapper/redirection merges.

---

## 2. In-Depth Critique per Commit

### Commit 1: `4b2f31435c7`
*Author: Richard Biener <rguenther@suse.de>*  
*Commit: `ipa-icf: Defer creating aliases until after inlining [PR105438]`*

#### Key Defects:
1. **Inlining Decision Asymmetry and Lost Merges:**
   ```cpp
   if (original->inlined_to)
     continue;
   ```
   If `original` is a local function called only once, the inliner inlines it into its single caller and marks `original->inlined_to != NULL`. Post-inlining, `ipa_icf_create_deferred_aliases` encounters this check and drops the merge completely. `alias`, which may have multiple un-inlined callers, is left unmerged. Whether two functions are merged becomes arbitrarily dependent on symbol table hash ordering (which selects which function is `original` vs `alias`).

2. **Inliner Cost and Growth Distortion:**
   Retaining `alias` as a full body through `ipa_fn_summary` and `ipa_inline` means `estimate_growth` treats `alias` as an independent entity that must be preserved offline unless inlined into all callers. The inliner does not credit the elimination of `alias` as an alias, skewing the inlining priority queue across the entire translation unit.

3. **Stale Profile Merging:**
   `ipa_merge_profiles (original, alias)` is deferred until after inlining. Callsite edge counts inlined during `ipa_inline` were calculated using unmerged, isolated profiles. Merging profiles post-inlining fails to back-propagate through already-inlined call sites, producing inconsistent frequency estimates in downstream RTL and tree passes.

4. **Flawed LTO Summary Streaming:**
   The commit originally introduced `ipa_icf_write_optimization_summary`, `ipa_icf_read_optimization_summary`, and `ipa_icf_transform`. Under LTO, `ipa_inline` runs at WPA and executes `ipa_icf_create_deferred_aliases ()`, creating symbol aliases before LTRANS partitions are formed. Streaming deferred aliases to LTRANS was completely redundant and produced extraneous ICF dump files in LTRANS runs (prompting removal in commit 2).

5. **Unchecked Clones on `original`:**
   In `ipa_icf_create_deferred_aliases`:
   ```cpp
   if (alias->clones || (in_lto_p && original->in_other_partition))
     {
       redirect_all_callers (alias, original);
       continue;
     }
   ```
   The check only tests `alias->clones` and ignores `original->clones`. If `original` was cloned or specialized by an intermediate pass, creating an alias directly to `original->decl` bypasses those clones or targets an unspecialized node.

---

### Commit 2: `4d613c36ad6`
*Author: Kees Cook <kees@kernel.org>*  
*Commit: `ipa-icf: Keep deferred merges from bypassing IPA-CP [PR105438]`*

#### Key Defects:
1. **Symptom-Patching That Silently Drops Valid Merges:**
   Commit 2 adds `ipcp_compatible_p` to verify whether parameter ranges narrowed by IPA-CP allow merging. If `ipcp_compatible_p` returns `false`, ICF's equivalence decision is silently abandoned. Deferring the merge directly causes IPA-CP to narrow ranges based on partial caller subsets, which subsequently prevents the merge.

2. **Complete Neglect of IPA-SRA Signature Transformations:**
   `ipcp_compatible_p` checks only `ipcp_transformation` (`m_vr` and `m_agg_values`). It completely ignores `pass_ipa_sra`, which also executes between ICF and inlining. IPA-SRA can split aggregate parameters or eliminate unused arguments. If IPA-SRA modifies `original` but not `alias`, post-inlining alias creation or redirection links call sites to functions with mismatched signatures, producing invalid GIMPLE and potential compiler crashes.

3. **Spurious Incompatibility via `types_compatible_p`:**
   In `ipcp_compatible_p`:
   ```cpp
   const ipa_vr &fvr = (*ft->m_vr)[i];
   if (!types_compatible_p (tvr.type (), fvr.type ()))
     return false;
   ```
   PR 105438 specifically arises when ICF merges functions operating on distinct pointer/struct types (e.g. `struct small *` vs `struct big *`). If IPA-CP happens to deduce a value range for a pointer argument (e.g. non-null), `types_compatible_p` returns `false` due to differing base types. Consequently, the merge is rejected if IPA-CP discovered non-nullness, but accepted if IPA-CP discovered nothing.

4. **Unhandled IPA-CP Cloning:**
   If IPA-CP specializes `original` by creating a clone (`create_specialized_node`) and redirects `original`'s callers to it, `original` may be left as an unspecialized or uncalled node. Redirecting `alias`'s callers to `original` routes execution to an unspecialized stub.

5. **Missed-Optimization Enshrined in Testsuite:**
   In `gcc.dg/ipa/pr105438-4.c`:
   ```c
   /* { dg-final { scan-ipa-dump {ICF: f[12]/[0-9]+ keeps its body; IPA-CP specialized f[12]/[0-9]+ for other calls} "inline" { target alias } } } */
   /* { dg-final { scan-ipa-dump-not {ICF: f[12]/[0-9]+ is now an alias} "inline" } } */
   ```
   The test explicitly asserts that ICF failed to merge identical functions, codifying an optimization regression as expected behavior.

6. **Contribution Policy / Metadata:**
   The commit trailer `Assisted-by: LLM [tests]` should be placed in the commit narrative rather than formatted as an official git trailer to conform to upstream GCC contribution and DCO guidelines.

---

### Commit 3: `5e4bdec0d78`
*Author: Kees Cook <kees@kernel.org>*  
*Commit: `ipa-icf: Inline the merged function's own body when it becomes a wrapper [PR105438]`*

#### Key Defects:
1. **Ineffective Under LTO (WPA):**
   In `make_inline_copy`:
   ```cpp
   if (in_lto_p
       || !gimple_has_body_p (alias->decl)
       || lookup_attribute ("noclone", DECL_ATTRIBUTES (alias->decl))
       || lookup_attribute ("noipa", DECL_ATTRIBUTES (alias->decl)))
     return 0;
   ```
   Because function bodies are not loaded at WPA time, `in_lto_p` causes `make_inline_copy` to immediately return `0`. Callers are redirected to `local_original` before inlining. At WPA, `ipa_inline` inlines `local_original`'s body into `alias`'s callers, leaving PR 105438 completely unfixed for LTO wrapper merges.

2. **Re-Duplication Defeating ICF Goals:**
   When wrapper merges occur, `make_inline_copy` calls `alias->create_version_clone_with_body ()`. This allocates a third copy of the function body (CFG, gimple statements, SSA names). In codebases with numerous duplicate functions (such as C++ template instantiations), this significantly increases compiler peak RSS during IPA.

3. **Inlining Heuristics Subverted via `force_output = true`:**
   Setting `copy->force_output = true` marks the clone as an unremovable symbol. In `ipa-inline-analysis.cc`, `will_be_removed_from_program_if_no_direct_calls_p ()` returns `false`, causing `offline_size ()` to return `0`. The inliner calculates code growth without subtracting the elimination of the function body, artificially penalizing inlining of the very clone created specifically to be inlined.

4. **Fragile Dead-Copy Cleanup:**
   Because `force_output` is set, `TODO_remove_functions` cannot reclaim copies whose callers disappear. The loop added to `ipa_icf_driver`:
   ```cpp
   for (auto &p : merge_inline_copies)
     if (p.first && !p.first->callers)
       p.first->force_output = false;
   ```
   only catches callers eliminated during ICF. If an intermediate pass (like `pass_ipa_devirt` or `pass_ipa_cp`) later eliminates the last caller, `copy` remains with `force_output = true` and no callers, reproducing the IPA-CP assertion on an uncalled local function.

5. **Latent Bug in `redirect_all_callers`:**
   In `redirect_all_callers`:
   ```cpp
   else
     e = e->next_callee;
   ```
   When `e` is an edge in `n->callers`, advancing via `next_callee` traverses the callee chain of `e->caller`, not `n->callers`.

6. **Unscheduled Reachability Sweeps:**
   Calling `symtab->remove_unreachable_nodes (dump_file)` directly within `move_inline_copy_calls` triggers a full callgraph sweep outside of the pass manager's standard TODO flag scheduling.

---

## 3. Recommended Structural Solutions

Rather than maintaining deferred state across five intermediate IPA passes, PR ipa/105438 should be solved through one of the following architectural approaches:

### Approach A: Differentiate Incompatible Layouts at ICF Time
If inlining a merged function will cause invalid memory references, diagnostic warnings, or TBAA violations due to mismatched pointer types or array bounds, ICF's equivalence checks (`func_checker::compatible_types_p` and `func_checker::compare_operand`) should not declare the functions identical when:
- Parameter types differ in array bounds or struct sizes.
- Memory access offsets or base types are not strictly identical across types.

### Approach B: Schedule ICF Post-Inlining
If ICF is intended to merge functions that survive inlining without impacting inlining decisions or diagnostics:
- Schedule an ICF pass after `pass_ipa_inline` (or as a late IPA / LTRANS deduplication pass).
- When ICF runs post-inlining, inlining has already completed using each caller's original body. ICF then only merges remaining out-of-line functions, eliminating the need for deferred alias vectors, removal hooks, inline-only copies, or IPA-CP compatibility checks.
