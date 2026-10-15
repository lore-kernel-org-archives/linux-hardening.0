Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF33E63AE
	for <linux-hardening@vger.kernel.org>; Thu, 15 Oct 2026 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792101241; cv=none; b=kH1UxLsfIh/Mq93hTwHhxR8dpeDdXQexY794FZyrB8vRWxXb067/QOidJNlCTXj/hTSoTELdmghWE27jM/isgd4Wo7PHXLsl/rmMl7z+UkGqluzNfl+i0xR2uF5aAV7z/0uS2LEfZfh+aN4ymI/VAMPPbH96OEaKGWW4MaOEuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792101241; c=relaxed/simple;
	bh=NgPFrSECctG3Mp6l25yrnWd6zQSyUh/T7OxU6RktG1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTstBC4UAjSKJoqwyrRyfeGrirzuixCQ3WiM73+8KebnOYNi72tMEU2UChSAI35IfEQO9SFu6wjLSwvN81rFoaenElPf4WagZfDOZGBVlvgR9BhMa8yML+FTxfsVujKkrGihljtSRO/jkIl1pssG8a3lwjsmvvptug558q1K4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnbRraux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnbRraux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A4C1F000C4;
	Thu, 15 Oct 2026 21:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792101238;
	bh=zwawWgRYeIey7H8Ql7eX/jMqhJilZ0cBpd3swzIr+Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZnbRrauxruyS5AOfQa6pRM1Hz+PpBLLJgcU5goZEvS9uAnlWeWpGf8KloAw9DRhzN
	 sQFM8WAJvFhznosFuC1V0+m5Hvtnn6EI8bgBUYOLMn2q8BJg3bvSzgBDV9WG7q74Qn
	 FJ96w3AD6FgKsViEWYFyCin7MlYlQVICTONAKuiUOq5HwmoxBd9z8Ou4iFVx/NNHSD
	 xhKyUtDKqh0UWm+mCMsr58yf4GOTW4Vk6NJCe7xySWR0A8lUbr9YrTfklYG+FGiPRk
	 L2wauzpmGZaG6oZT6eknfwXtH+H8DvBJUU0s2IjqKc5St83by+gYFAdYj47GUNM4zB
	 EaVCLOg0RIYaw==
Date: Thu, 15 Oct 2026 14:53:58 -0700
From: Kees Cook <kees@kernel.org>
To: Richard Biener <rguenther@suse.de>
Cc: Richard Biener <richard.guenther@gmail.com>,
	Jan Hubicka <hubicka@ucw.cz>, Martin Jambor <mjambor@suse.cz>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipa-icf: Compare access path type sizes without TBAA
 [PR105438]
Message-ID: <20261015215136.adec8b-kees@kernel.org>
References: <20261010050537.i.784-kees@kernel.org>
 <CAFiYyc2gYAjiKDi+TeC9_qEX+LHa7fSxj42JjRtM6Dbi6Yfidw@mail.gmail.com>
 <20261015052441.7d2b3c-kees@kernel.org>
 <39r25275-0488-rq01-55nq-28rs192rp368@fhfr.qr>
 <76op6r8p-n2p7-r6p8-s541-rs310035q364@fhfr.qr>
 <21s7p869-5267-7nq1-701q-p35771ss56qp@fhfr.qr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9b2nh3KoyAsvLx9k"
Content-Disposition: inline
In-Reply-To: <21s7p869-5267-7nq1-701q-p35771ss56qp@fhfr.qr>


--9b2nh3KoyAsvLx9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 02:04:44PM +0200, Richard Biener wrote:
> A few kg CO2 later here's a prototype that looks like proper IPA
> and LTO capable.  Note it still does varpool handling early which
> I think is OK.  I'm not sure it fits a possible design of different
> inline from non-inline bodies in more general (GNU extern inline).

Thanks for this! I gave it a spin. It fixes both PR105438
testcases and a static-function case (the second patch adds it as
gcc.dg/ipa/pr105438-5.c), but I ran into a few problems. These are solved
by the two attached patches that apply on top of yours (on 84348add236):

1. Wrong code from IPA-CP. With the alias deferred, IPA-CP runs between
   the merge decision and the alias. For a local function it can't
   clone, it narrows the parameter ranges in place to what its own
   calls pass, so making the other function an alias of it sends it
   values outside them. 27 of the c-c++-common/torture/
   builtin-arith-overflow tests abort at -O2 -flto, in C and C++, and
   this aborts at plain -O2:

     __attribute__ ((noinline, noclone)) static int
     f1 (int x, int y) { return x * 7 + y; }
     __attribute__ ((noinline, noclone)) static int
     f2 (int x, int y) { return x * 7 + y; }

     __attribute__ ((noinline)) int t1 (void) { return f1 (2, 3); }
     __attribute__ ((noinline)) int t2 (void) { return f2 (5, 1); }

   t2 returns 17. The first patch makes the alias, or redirects the
   alias's calls, only when the ranges IPA-CP gave the alias's
   parameters are within the original's.

2. Nodes in deferred_merge_aliases can be removed before the list is
   processed, by the IPA passes between ICF and the inliner. Building
   the kernel's fs/ext4/super.c crashed in
   can_remove_if_no_direct_calls_p on a removed node. The first patch
   adds a cgraph removal hook.

3. Your g++.dg/lto/pr105438_0.C passes without your patch: with -r the
   link is incremental and ICF never runs. The first patch adds
   -flinker-output=nolto-rel so it'll fail on master and pass with
   your patch.

4. It doesn't look like the optimization summary and the function
   transform are needed. Under LTO the inliner, and with it the alias
   creation, runs at WPA, so the aliases reach LTRANS the way ICF's
   aliases do now, and inline_transform already redirects the call
   statements. At LTRANS every streamed pair should already be an
   alias. Reading them also opened an ICF dump at LTRANS, which
   outputs.exp reports as an extra file (68 new FAILs). The first patch
   removes both hooks.

5. Only the alias path was deferred, so merges that took the
   wrapper/redirect path still inlined the other body: two global
   functions (both addresses matter), and everything on targets
   without symbol aliases. My original two-global-functions case still
   warned. The second patch handles that path with an inline-only copy:
   before the calls are redirected, the merged function's direct calls
   go to a copy of its own body, the wrapper is made as before, and
   after inlining the calls that weren't inlined go to the original and
   the copies go away. (I first tried just deferring the wrapper, but
   then the inliner never inlines the original into the wrapper, which
   changed code generation all over the testsuite and broke
   always_inline functions and interrupt handlers.)

With both patches on yours, check-c and check-c++ on x86_64 match
master. For the paths without symbol aliases I checked with an
x86_64-apple-darwin cross compiler. An x86_64 allmodconfig kernel build
gets the same ICF merge count as master and 7038 bytes more text (of
648 MB, so no big deal).

The kernel case that started this, net/ipv6/ip6_tunnel.c, gets 16
warnings on m68k from GCC 16 but none from master, where r17-4004's
check keeps the two functions apart because of their memcpy. The same
code without the memcpy still gets the 16 warnings from master on
m68k, and none with your patch, with or without mine on top.

> > I'm sure this can be completed with some interaction, but our AI
> > policy makes this questionable.

These were written with an LLM's help too, especially the build
orchestration and test creation. It has been explaining the glitches it
found to me, and that's shaped the code, but I'm hardly a subject matter
expert on aliases, inlining, and ICF. :P

But if this direction looks right to you, we don't need my access
path patch.

-Kees

-- 
Kees Cook

--9b2nh3KoyAsvLx9k
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ipa-icf-Keep-deferred-merges-from-bypassing-IPA-CP-P.patch"

From 2326729956106717ec1a2a0224c69419bd3f234f Mon Sep 17 00:00:00 2001
From: Kees Cook <kees@kernel.org>
Date: Thu, 15 Oct 2026 09:30:14 -0700
Subject: [PATCH 1/2] ipa-icf: Keep deferred merges from bypassing IPA-CP
 [PR105438]

A fix for "ipa-icf: Defer creating aliases until after inlining",
meant to be folded into it.

With the alias deferred until after inlining, IPA-CP runs between the
merge decision and the alias, on both bodies.  When it can't clone a
local function, it narrows the ranges of its parameters in place to
what its own calls pass, so making another function an alias of it
sends calls with other values to a body optimized for its values.  In
gcc.dg/ipa/pr105438-3.c, f1 is called only as f1 (2, 3) and f2 only as
f2 (5, 1), both noinline and noclone; they merge, and t2's call of f2
returns f1 (2, 3).  The c-c++-common/torture/builtin-arith-overflow
tests abort the same way at -O2 -flto.  Make the alias, or redirect the
alias's callers, only when the ranges IPA-CP gave the alias's
parameters are within those it gave the original's.

The nodes of a deferred pair can also be removed before it is
processed, by the IPA passes between ICF and the inliner or by the
inliner; forget the pair when one is.  Without that, the Linux kernel's
fs/ext4/super.c crashes in can_remove_if_no_direct_calls_p, called on
a removed node.

Drop the optimization summary and the function transform.  Under LTO
the inliner, and with it the alias creation, runs at WPA, so the
aliases reach LTRANS like those ICF makes before inlining, and
inline_transform already redirects the call statements.  At LTRANS the
streamed pairs were all aliases already, and reading them opened an ICF
dump there, which outputs.exp counts as an extra file.

Also dump each alias made after inlining, and link the LTO test with
-flinker-output=nolto-rel: with -r alone the link is incremental, ICF
never runs, and the test passes without the patch.

Assisted-by: LLM [tests]

	PR ipa/105438

gcc/ChangeLog:

	* ipa-icf.cc (deferred_merge_removal_hook): New variable.
	(deferred_merge_node_removed, watch_deferred_merges)
	(unwatch_deferred_merges): New functions.
	(sem_function::merge): Watch the deferred merges.
	(ipa_icf_write_optimization_summary)
	(ipa_icf_read_optimization_summary, ipa_icf_transform): Remove.
	(pass_ipa_icf::pass_ipa_icf): Don't register them.
	(ipcp_compatible_p): New function.
	(ipa_icf_create_deferred_aliases): Skip removed pairs and use
	ipcp_compatible_p.  Release the list at WPA too, and drop the
	check for an original in another partition.  Dump each alias
	made.  Stop watching.
	(ipa_icf_cc_finalize): Stop watching.

gcc/testsuite/ChangeLog:

	* g++.dg/lto/pr105438_0.C: Link with -flinker-output=nolto-rel.
	* gcc.dg/ipa/pr105438-3.c: New test.
	* gcc.dg/ipa/pr105438-4.c: New test.
	* gcc.dg/lto/pr105438_0.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/ipa-icf.cc                        | 222 +++++++++++---------------
 gcc/testsuite/g++.dg/lto/pr105438_0.C |   2 +-
 gcc/testsuite/gcc.dg/ipa/pr105438-3.c |  40 +++++
 gcc/testsuite/gcc.dg/ipa/pr105438-4.c |  52 ++++++
 gcc/testsuite/gcc.dg/lto/pr105438_0.c |  39 +++++
 5 files changed, 228 insertions(+), 127 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/ipa/pr105438-3.c
 create mode 100644 gcc/testsuite/gcc.dg/ipa/pr105438-4.c
 create mode 100644 gcc/testsuite/gcc.dg/lto/pr105438_0.c

diff --git a/gcc/ipa-icf.cc b/gcc/ipa-icf.cc
index 8d580f99474..30ddaca2a4e 100644
--- a/gcc/ipa-icf.cc
+++ b/gcc/ipa-icf.cc
@@ -101,6 +101,40 @@ namespace ipa_icf {
 
 static sem_item_optimizer *optimizer = NULL;
 static vec<std::pair<cgraph_node *, cgraph_node *> > deferred_merge_aliases;
+static cgraph_node_hook_list *deferred_merge_removal_hook;
+
+/* Forget the deferred merges of NODE when it is removed: the IPA passes
+   between ICF and the inliner, and the inliner, may remove it.  */
+
+static void
+deferred_merge_node_removed (cgraph_node *node, void *)
+{
+  for (auto &p : deferred_merge_aliases)
+    if (p.first == node || p.second == node)
+      p.first = p.second = NULL;
+}
+
+/* Watch for the removal of the nodes of the deferred merges.  */
+
+static void
+watch_deferred_merges (void)
+{
+  if (!deferred_merge_removal_hook)
+    deferred_merge_removal_hook
+      = symtab->add_cgraph_removal_hook (deferred_merge_node_removed, NULL);
+}
+
+/* Stop watching for it.  */
+
+static void
+unwatch_deferred_merges (void)
+{
+  if (deferred_merge_removal_hook)
+    {
+      symtab->remove_cgraph_removal_hook (deferred_merge_removal_hook);
+      deferred_merge_removal_hook = NULL;
+    }
+}
 
 /* Constructor.  */
 
@@ -1289,6 +1323,7 @@ sem_function::merge (sem_item *alias_item)
       original->icf_merged = true;
 
       deferred_merge_aliases.safe_push (std::make_pair (original, alias));
+      watch_deferred_merges ();
 
       if (dump_enabled_p ())
 	dump_printf (MSG_OPTIMIZED_LOCATIONS,
@@ -3665,126 +3700,6 @@ ipa_icf_driver (void)
   return merged_p ? TODO_remove_functions : 0;
 }
 
-/* Write optimization summary for IPA-ICF.  */
-
-static void
-ipa_icf_write_optimization_summary (void)
-{
-  struct output_block *ob = create_output_block (LTO_section_ipa_icf);
-  lto_symtab_encoder_t encoder = ob->decl_state->symtab_node_encoder;
-  auto_vec<std::pair<cgraph_node *, cgraph_node *> > to_write;
-
-  for (unsigned i = 0; i < deferred_merge_aliases.length (); i++)
-    {
-      cgraph_node *original
-	= deferred_merge_aliases[i].first->ultimate_alias_target ();
-      cgraph_node *alias = deferred_merge_aliases[i].second;
-
-      if (lto_symtab_encoder_in_partition_p (encoder, alias)
-	  || lto_symtab_encoder_in_partition_p (encoder, original)
-	  || lto_symtab_encoder_lookup (encoder, alias) != LCC_NOT_FOUND)
-	to_write.safe_push (std::make_pair (original, alias));
-    }
-
-  streamer_write_uhwi (ob, to_write.length ());
-  for (unsigned i = 0; i < to_write.length (); i++)
-    {
-      cgraph_node *original = to_write[i].first;
-      cgraph_node *alias = to_write[i].second;
-
-      int orig_ref = lto_symtab_encoder_encode (encoder, original);
-      int alias_ref = lto_symtab_encoder_encode (encoder, alias);
-      streamer_write_uhwi (ob, orig_ref);
-      streamer_write_uhwi (ob, alias_ref);
-    }
-
-  produce_asm (ob);
-  destroy_output_block (ob);
-}
-
-/* Read optimization summary for IPA-ICF.  */
-
-static void
-ipa_icf_read_optimization_summary (void)
-{
-  lto_file_decl_data **file_data_vec = lto_get_file_decl_data ();
-  lto_file_decl_data *file_data;
-  unsigned int j = 0;
-
-  while ((file_data = file_data_vec[j++]))
-    {
-      size_t len;
-      const char *data
-	= lto_get_summary_section_data (file_data, LTO_section_ipa_icf, &len);
-      if (!data)
-	continue;
-
-      const class lto_function_header *header
-	= (const struct lto_function_header *) data;
-      const int cfg_offset = sizeof (struct lto_function_header);
-      const int main_offset = cfg_offset + header->cfg_size;
-      const int string_offset = main_offset + header->main_size;
-      class data_in *data_in;
-      class lto_input_block ib_main ((const char *) data + main_offset, 0,
-				     header->main_size, file_data);
-
-      data_in
-	= lto_data_in_create (file_data, (const char *) data + string_offset,
-			      header->string_size, vNULL);
-
-      unsigned int count = streamer_read_uhwi (&ib_main);
-      lto_symtab_encoder_t encoder = file_data->symtab_node_encoder;
-
-      for (unsigned int i = 0; i < count; i++)
-	{
-	  unsigned int orig_ref = streamer_read_uhwi (&ib_main);
-	  unsigned int alias_ref = streamer_read_uhwi (&ib_main);
-
-	  cgraph_node *original
-	    = dyn_cast<cgraph_node *> (lto_symtab_encoder_deref (encoder,
-								orig_ref));
-	  cgraph_node *alias
-	    = dyn_cast<cgraph_node *> (lto_symtab_encoder_deref (encoder,
-								alias_ref));
-	  if (original && alias)
-	    {
-	      std::pair<cgraph_node *, cgraph_node *> p (original, alias);
-	      if (!deferred_merge_aliases.contains (p))
-		deferred_merge_aliases.safe_push (p);
-	    }
-	}
-
-      lto_free_section_data (file_data, LTO_section_ipa_icf, NULL, data, len);
-      lto_data_in_delete (data_in);
-    }
-
-  if (deferred_merge_aliases.length ())
-    ::ipa_icf_create_deferred_aliases ();
-}
-
-/* Transform hook for IPA-ICF.  */
-
-static unsigned int
-ipa_icf_transform (struct cgraph_node *node)
-{
-  bool modified = false;
-
-  for (cgraph_edge *e = node->callees; e; e = e->next_callee)
-    {
-      if (e->inline_failed
-	  && e->callee->icf_merged
-	  && e->call_stmt
-	  && (!gimple_call_fndecl (e->call_stmt)
-	      || e->callee->decl != gimple_call_fndecl (e->call_stmt)))
-	{
-	  cgraph_edge::redirect_call_stmt_to_callee (e);
-	  modified = true;
-	}
-    }
-
-  return modified ? TODO_update_ssa_only_virtuals : 0;
-}
-
 const pass_data pass_data_ipa_icf =
 {
   IPA_PASS,		    /* type */
@@ -3806,11 +3721,13 @@ public:
 		      ipa_icf_generate_summary, /* generate_summary */
 		      ipa_icf_write_summary, /* write_summary */
 		      ipa_icf_read_summary, /* read_summary */
-		      ipa_icf_write_optimization_summary, /* write_optimization_summary */
-		      ipa_icf_read_optimization_summary, /* read_optimization_summary */
+		      NULL, /*
+		      write_optimization_summary */
+		      NULL, /*
+		      read_optimization_summary */
 		      NULL, /* stmt_fixup */
 		      0, /* function_transform_todo_flags_start */
-		      ipa_icf_transform, /* function_transform */
+		      NULL, /* function_transform */
 		      NULL) /* variable_transform */
   {}
 
@@ -3836,6 +3753,42 @@ make_pass_ipa_icf (gcc::context *ctxt)
   return new ipa_icf::pass_ipa_icf (ctxt);
 }
 
+/* Return true if the calls of FROM may go to TO.  IPA-CP ran after the
+   merge was decided, on both bodies, and may have narrowed the ranges of
+   TO's parameters to the values its own calls pass, so the calls of FROM
+   must pass values within them.  */
+
+static bool
+ipcp_compatible_p (cgraph_node *from, cgraph_node *to)
+{
+  ipcp_transformation *tt = ipcp_get_transformation_summary (to);
+  if (!tt)
+    return true;
+  if (!vec_safe_is_empty (tt->m_agg_values))
+    return false;
+
+  ipcp_transformation *ft = ipcp_get_transformation_summary (from);
+  for (unsigned i = 0; i < vec_safe_length (tt->m_vr); i++)
+    {
+      const ipa_vr &tvr = (*tt->m_vr)[i];
+      if (!tvr.known_p ())
+	continue;
+      if (!ft || i >= vec_safe_length (ft->m_vr) || !(*ft->m_vr)[i].known_p ())
+	return false;
+
+      const ipa_vr &fvr = (*ft->m_vr)[i];
+      if (!types_compatible_p (tvr.type (), fvr.type ()))
+	return false;
+      value_range tr, fr;
+      tvr.get_vrange (tr);
+      fvr.get_vrange (fr);
+      /* The union widens TR unless FR is within it.  */
+      if (tr.union_ (fr))
+	return false;
+    }
+  return true;
+}
+
 /* Create deferred ICF aliases after inlining.  */
 
 void
@@ -3843,6 +3796,10 @@ ipa_icf_create_deferred_aliases (void)
 {
   for (unsigned i = 0; i < deferred_merge_aliases.length (); i++)
     {
+      /* A pair whose node was removed.  */
+      if (!deferred_merge_aliases[i].second)
+	continue;
+
       cgraph_node *original
 	= deferred_merge_aliases[i].first->ultimate_alias_target ();
       cgraph_node *alias = deferred_merge_aliases[i].second;
@@ -3859,7 +3816,16 @@ ipa_icf_create_deferred_aliases (void)
       if (original->inlined_to)
 	continue;
 
-      if (alias->clones || (in_lto_p && original->in_other_partition))
+      if (!ipcp_compatible_p (alias, original))
+	{
+	  if (dump_file)
+	    fprintf (dump_file, "ICF: %s keeps its body; IPA-CP specialized "
+		     "%s for other calls.\n", alias->dump_name (),
+		     original->dump_name ());
+	  continue;
+	}
+
+      if (alias->clones)
 	{
 	  /* If alias has inline clones, we cannot release its body.
 	     Redirect direct callers to original instead.  */
@@ -3885,9 +3851,12 @@ ipa_icf_create_deferred_aliases (void)
       alias->resolve_alias (original);
       original->call_for_symbol_thunks_and_aliases
 	(set_local, (void *)(size_t) original->local_p (), true);
+      if (dump_file)
+	fprintf (dump_file, "ICF: %s is now an alias of %s.\n",
+		 alias->dump_name (), original->dump_name ());
     }
-  if (!flag_wpa)
-    deferred_merge_aliases.release ();
+  deferred_merge_aliases.release ();
+  unwatch_deferred_merges ();
 }
 
 /* Reset all state within ipa-icf.cc so that we can rerun the compiler
@@ -3897,5 +3866,6 @@ void
 ipa_icf_cc_finalize (void)
 {
   ipa_icf::optimizer = NULL;
+  unwatch_deferred_merges ();
   deferred_merge_aliases.release ();
 }
diff --git a/gcc/testsuite/g++.dg/lto/pr105438_0.C b/gcc/testsuite/g++.dg/lto/pr105438_0.C
index 46e3b458b5f..b168e54cd2a 100644
--- a/gcc/testsuite/g++.dg/lto/pr105438_0.C
+++ b/gcc/testsuite/g++.dg/lto/pr105438_0.C
@@ -1,7 +1,7 @@
 // { dg-lto-do link }
 // { dg-require-effective-target lto_incremental }
 // { dg-lto-options { { -O2 -flto -fno-strict-aliasing -Werror=array-bounds } } }
-// { dg-extra-ld-options "-r -nostdlib" }
+// { dg-extra-ld-options "-r -nostdlib -flinker-output=nolto-rel" }
 
 int longer[7] = {};
 int shorter[2] = {};
diff --git a/gcc/testsuite/gcc.dg/ipa/pr105438-3.c b/gcc/testsuite/gcc.dg/ipa/pr105438-3.c
new file mode 100644
index 00000000000..e4ebb0058e3
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/ipa/pr105438-3.c
@@ -0,0 +1,40 @@
+/* PR ipa/105438 */
+/* { dg-do run } */
+/* { dg-options "-O2" } */
+
+/* ICF merges f1 and f2, and IPA-CP, which runs before the merge is
+   carried out after inlining, narrows the range of each one's parameters
+   to the constants of its own call, in place since neither can be cloned.
+   The calls of one must not go to the other.  */
+
+__attribute__ ((noinline, noclone)) static int
+f1 (int x, int y)
+{
+  return x * 7 + y;
+}
+
+__attribute__ ((noinline, noclone)) static int
+f2 (int x, int y)
+{
+  return x * 7 + y;
+}
+
+__attribute__ ((noinline)) int
+t1 (void)
+{
+  return f1 (2, 3);
+}
+
+__attribute__ ((noinline)) int
+t2 (void)
+{
+  return f2 (5, 1);
+}
+
+int
+main ()
+{
+  if (t1 () != 17 || t2 () != 36)
+    __builtin_abort ();
+  return 0;
+}
diff --git a/gcc/testsuite/gcc.dg/ipa/pr105438-4.c b/gcc/testsuite/gcc.dg/ipa/pr105438-4.c
new file mode 100644
index 00000000000..1cf87c7375a
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/ipa/pr105438-4.c
@@ -0,0 +1,52 @@
+/* PR ipa/105438 */
+/* { dg-do compile } */
+/* { dg-options "-O2 -fdump-ipa-icf-optimized -fdump-ipa-inline" } */
+
+/* As in pr105438-3.c, IPA-CP narrows the ranges of the parameters of
+   each function to the constants of its own call.  The f pair is called
+   with different constants, so neither becomes an alias of the other;
+   the g pair is called with the same ones, so one does.  */
+
+__attribute__ ((noinline, noclone)) static int
+f1 (int x, int y)
+{
+  return x * 7 + y;
+}
+
+__attribute__ ((noinline, noclone)) static int
+f2 (int x, int y)
+{
+  return x * 7 + y;
+}
+
+__attribute__ ((noinline, noclone)) static int
+g1 (int x, int y)
+{
+  return x * 5 + y;
+}
+
+__attribute__ ((noinline, noclone)) static int
+g2 (int x, int y)
+{
+  return x * 5 + y;
+}
+
+int
+t1 (void)
+{
+  return f1 (2, 3) + g1 (2, 3);
+}
+
+int
+t2 (void)
+{
+  return f2 (5, 1) + g2 (2, 3);
+}
+
+/* { dg-final { scan-ipa-dump {Semantic equality hit:f[12]/[0-9]+->f[12]/[0-9]+} "icf" } } */
+/* { dg-final { scan-ipa-dump {Semantic equality hit:g[12]/[0-9]+->g[12]/[0-9]+} "icf" } } */
+/* Without symbol aliases, the merges make wrappers or remove bodies
+   before inlining.  */
+/* { dg-final { scan-ipa-dump {ICF: f[12]/[0-9]+ keeps its body; IPA-CP specialized f[12]/[0-9]+ for other calls} "inline" { target alias } } } */
+/* { dg-final { scan-ipa-dump-not {ICF: f[12]/[0-9]+ is now an alias} "inline" } } */
+/* { dg-final { scan-ipa-dump {ICF: g[12]/[0-9]+ is now an alias of g[12]/[0-9]+} "inline" { target alias } } } */
diff --git a/gcc/testsuite/gcc.dg/lto/pr105438_0.c b/gcc/testsuite/gcc.dg/lto/pr105438_0.c
new file mode 100644
index 00000000000..4d44f7f8b19
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/lto/pr105438_0.c
@@ -0,0 +1,39 @@
+/* PR ipa/105438 */
+/* { dg-lto-do run } */
+/* { dg-lto-options { { -O2 -flto } } } */
+
+/* As gcc.dg/ipa/pr105438-3.c, with LTO: the functions are local to the
+   program, IPA-CP narrows the ranges of each one's parameters to the
+   constants of its own call, and LTRANS must not merge them either.  */
+
+__attribute__ ((noinline, noclone)) int
+f1 (int x, int y)
+{
+  return x * 7 + y;
+}
+
+__attribute__ ((noinline, noclone)) int
+f2 (int x, int y)
+{
+  return x * 7 + y;
+}
+
+__attribute__ ((noinline)) int
+t1 (void)
+{
+  return f1 (2, 3);
+}
+
+__attribute__ ((noinline)) int
+t2 (void)
+{
+  return f2 (5, 1);
+}
+
+int
+main ()
+{
+  if (t1 () != 17 || t2 () != 36)
+    __builtin_abort ();
+  return 0;
+}
-- 
2.53.0


--9b2nh3KoyAsvLx9k
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-ipa-icf-Inline-the-merged-function-s-own-body-when-i.patch"

From 1e2174fd4419135ae739be293d25ac19927cd180 Mon Sep 17 00:00:00 2001
From: Kees Cook <kees@kernel.org>
Date: Thu, 15 Oct 2026 10:35:53 -0700
Subject: [PATCH 2/2] ipa-icf: Inline the merged function's own body when it
 becomes a wrapper [PR105438]

Deferring the alias covers merges where ICF makes one function an alias
of the other, but not those where it can't: when both functions'
addresses matter, as for two global functions, on targets without
symbol aliases, or across a discardable original.  There it redirects
the direct calls to the original and makes the merged function a
wrapper, or removes its body, before inlining, so an inlined call gets
the original's body with the original's types, and -Warray-bounds
warns:

    struct small { char pad[16]; int a; unsigned int b, c; };
    struct big { char pad[16]; int a; unsigned int b, c; int extra; };

    void small_to_big (struct big *d, const struct small *s) { ... }
    void big_to_small (struct small *d, const struct big *s) { ... }

    void f (struct big *b)
    {
      struct small s;

      big_to_small (&s, b);
      small_to_big (b, &s);	/* inlines big_to_small's body */
    }

Keep the wrapper and the redirection as they are, since the inliner may
inline the original into the wrapper, but first send the merged
function's direct calls to an inline-only copy of its own body.  The
copy is kept as hard to remove as the merged function during inlining,
so the inliner weighs the calls as before rather than as calls of a
local function called once.  After inlining, the calls it didn't inline
go to the original, as they would have, unless IPA-CP specialized the
original for other calls, and the copies are removed.

A later merge can release the body holding a copy's only call;
ICF's TODO_remove_functions then removes the copy, since IPA-CP
asserts on a local function without calls (e.g. the Linux kernel's
kernel/sched/debug.c merges schedstat_next, which calls schedstat_start,
after schedstat_start).

No copy is made at WPA, where the body isn't loaded, or of a noclone or
noipa function, and callback edges, which stand for the function's
address passed in another call, stay with the merged function.

Assisted-by: LLM

	PR ipa/105438

gcc/ChangeLog:

	* ipa-icf.cc (merge_inline_copies): New variable.
	(deferred_merge_node_removed): Forget the copies too.
	(make_inline_copy): New function.
	(sem_function::merge): Use it before redirecting the callers.
	(ipa_icf_driver): Let copies left without calls be removed.
	(move_inline_copy_calls): New function.
	(ipa_icf_create_deferred_aliases): Call it.
	(ipa_icf_cc_finalize): Release merge_inline_copies.

gcc/testsuite/ChangeLog:

	* gcc.dg/ipa/pr105438-1.c: New test.
	* gcc.dg/ipa/pr105438-2.c: New test.
	* gcc.dg/ipa/pr105438-5.c: New test.
	* gcc.dg/ipa/pr105438-6.c: New test.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 gcc/ipa-icf.cc                        | 117 +++++++++++++++++++++++++-
 gcc/testsuite/gcc.dg/ipa/pr105438-1.c |  86 +++++++++++++++++++
 gcc/testsuite/gcc.dg/ipa/pr105438-2.c | 115 +++++++++++++++++++++++++
 gcc/testsuite/gcc.dg/ipa/pr105438-5.c |  98 +++++++++++++++++++++
 gcc/testsuite/gcc.dg/ipa/pr105438-6.c |  50 +++++++++++
 5 files changed, 464 insertions(+), 2 deletions(-)
 create mode 100644 gcc/testsuite/gcc.dg/ipa/pr105438-1.c
 create mode 100644 gcc/testsuite/gcc.dg/ipa/pr105438-2.c
 create mode 100644 gcc/testsuite/gcc.dg/ipa/pr105438-5.c
 create mode 100644 gcc/testsuite/gcc.dg/ipa/pr105438-6.c

diff --git a/gcc/ipa-icf.cc b/gcc/ipa-icf.cc
index 30ddaca2a4e..252fb389da3 100644
--- a/gcc/ipa-icf.cc
+++ b/gcc/ipa-icf.cc
@@ -101,6 +101,11 @@ namespace ipa_icf {
 
 static sem_item_optimizer *optimizer = NULL;
 static vec<std::pair<cgraph_node *, cgraph_node *> > deferred_merge_aliases;
+
+/* Inline-only copies of the bodies of merged functions that became
+   wrappers or lost their bodies, each with the function their calls go
+   to once inlining is done.  */
+static vec<std::pair<cgraph_node *, cgraph_node *> > merge_inline_copies;
 static cgraph_node_hook_list *deferred_merge_removal_hook;
 
 /* Forget the deferred merges of NODE when it is removed: the IPA passes
@@ -112,6 +117,9 @@ deferred_merge_node_removed (cgraph_node *node, void *)
   for (auto &p : deferred_merge_aliases)
     if (p.first == node || p.second == node)
       p.first = p.second = NULL;
+  for (auto &p : merge_inline_copies)
+    if (p.first == node || p.second == node)
+      p.first = p.second = NULL;
 }
 
 /* Watch for the removal of the nodes of the deferred merges.  */
@@ -1056,6 +1064,48 @@ redirect_all_callers (cgraph_node *n, cgraph_node *to)
   return nredirected;
 }
 
+/* Before the calls of ALIAS are redirected to TO, the function it was
+   merged into, send its direct calls to an inline-only copy of its body,
+   so that a call the inliner inlines gets ALIAS's own body, with its own
+   types, and not TO's.  The calls that aren't inlined go to TO after
+   inlining (move_inline_copy_calls).  Return the number of calls sent to
+   the copy.  */
+
+static int
+make_inline_copy (cgraph_node *alias, cgraph_node *to)
+{
+  /* The copy needs the body, which isn't loaded at WPA; noclone and noipa
+     ask not to copy the function.  */
+  if (in_lto_p
+      || !gimple_has_body_p (alias->decl)
+      || lookup_attribute ("noclone", DECL_ATTRIBUTES (alias->decl))
+      || lookup_attribute ("noipa", DECL_ATTRIBUTES (alias->decl)))
+    return 0;
+
+  /* A callback edge stands for ALIAS's address passed in another call,
+     which the inliner can't inline.  */
+  auto_vec<cgraph_edge *> calls;
+  for (cgraph_edge *e = alias->callers; e; e = e->next_caller)
+    if (!e->caller->thunk && !e->callback)
+      calls.safe_push (e);
+  if (calls.is_empty ())
+    return 0;
+
+  cgraph_node *copy
+    = alias->create_version_clone_with_body (calls.to_vec_legacy (), NULL,
+					     NULL, NULL, NULL, "icf");
+  if (!copy)
+    return 0;
+
+  /* The inliner must weigh the calls as it would ALIAS's, whose body it
+     couldn't remove: not as a local function called once.  */
+  copy->force_output = true;
+
+  merge_inline_copies.safe_push (std::make_pair (copy, to));
+  watch_deferred_merges ();
+  return calls.length ();
+}
+
 /* Merges instance with an ALIAS_ITEM, where alias, thunk or redirection can
    be applied.  */
 
@@ -1294,14 +1344,19 @@ sem_function::merge (sem_item *alias_item)
 
   if (redirect_callers)
     {
+      int ncopied = make_inline_copy (alias, local_original);
       int nredirected = redirect_all_callers (alias, local_original);
 
-      if (nredirected)
+      if (nredirected || ncopied)
 	{
 	  alias->icf_merged = true;
 	  local_original->icf_merged = true;
 
-	  if (dump_enabled_p ())
+	  if (ncopied && dump_enabled_p ())
+	    dump_printf (MSG_NOTE,
+			 "%i local calls go to an inline-only copy.\n",
+			 ncopied);
+	  if (nredirected && dump_enabled_p ())
 	    dump_printf (MSG_NOTE,
 			 "%i local calls have been "
 			 "redirected.\n", nredirected);
@@ -3697,6 +3752,14 @@ ipa_icf_driver (void)
   delete optimizer;
   optimizer = NULL;
 
+  /* A later merge can release the body holding the only call of an
+     inline-only copy.  Let TODO_remove_functions remove such a copy: the
+     IPA passes before the inliner don't expect a local function without
+     calls.  */
+  for (auto &p : merge_inline_copies)
+    if (p.first && !p.first->callers)
+      p.first->force_output = false;
+
   return merged_p ? TODO_remove_functions : 0;
 }
 
@@ -3789,11 +3852,60 @@ ipcp_compatible_p (cgraph_node *from, cgraph_node *to)
   return true;
 }
 
+/* After inlining, send the calls of the inline-only copies that weren't
+   inlined to the functions the copied functions were merged into, and
+   remove the copies that are left unused.  */
+
+static void
+move_inline_copy_calls (void)
+{
+  bool any = false;
+
+  for (unsigned i = 0; i < merge_inline_copies.length (); i++)
+    {
+      cgraph_node *copy = merge_inline_copies[i].first;
+      cgraph_node *to = merge_inline_copies[i].second;
+
+      /* A copy whose node was removed.  */
+      if (!copy)
+	continue;
+      any = true;
+      copy->force_output = false;
+
+      /* The inliner may have made COPY or TO itself the inline clone of
+	 its last call.  */
+      if (copy->inlined_to || to->inlined_to)
+	continue;
+
+      if (!ipcp_compatible_p (copy, to->ultimate_alias_target ()))
+	{
+	  if (dump_file)
+	    fprintf (dump_file, "ICF: %s keeps its calls; IPA-CP specialized "
+		     "%s for other calls.\n", copy->dump_name (),
+		     to->dump_name ());
+	  continue;
+	}
+
+      int nredirected = redirect_all_callers (copy, to);
+      if (nredirected && dump_file)
+	fprintf (dump_file, "ICF: %i calls of %s not inlined have been "
+		 "redirected to %s.\n", nredirected, copy->dump_name (),
+		 to->dump_name ());
+    }
+  merge_inline_copies.release ();
+
+  /* Remove the copies' offline bodies; their inline clones keep them.  */
+  if (any)
+    symtab->remove_unreachable_nodes (dump_file);
+}
+
 /* Create deferred ICF aliases after inlining.  */
 
 void
 ipa_icf_create_deferred_aliases (void)
 {
+  move_inline_copy_calls ();
+
   for (unsigned i = 0; i < deferred_merge_aliases.length (); i++)
     {
       /* A pair whose node was removed.  */
@@ -3868,4 +3980,5 @@ ipa_icf_cc_finalize (void)
   ipa_icf::optimizer = NULL;
   unwatch_deferred_merges ();
   deferred_merge_aliases.release ();
+  merge_inline_copies.release ();
 }
diff --git a/gcc/testsuite/gcc.dg/ipa/pr105438-1.c b/gcc/testsuite/gcc.dg/ipa/pr105438-1.c
new file mode 100644
index 00000000000..9288541a593
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/ipa/pr105438-1.c
@@ -0,0 +1,86 @@
+/* PR ipa/105438 */
+/* { dg-do compile } */
+/* { dg-options "-O2 -fno-strict-aliasing -fno-early-inlining -Warray-bounds -fdump-ipa-icf-details -fdump-ipa-inline" } */
+
+/* ICF merges each pair below, and since the functions are global, it
+   can't make one an alias of the other: it makes the merged function a
+   wrapper and redirects its calls.  The calls go to an inline-only copy
+   of the merged function's own body first, so an inlined call gets that
+   body, not the other function's with the wrong types.  */
+
+void ext (int);
+
+struct small { char pad[16]; int a; unsigned int b, c; };
+struct big { char pad[16]; int a; unsigned int b, c; int extra; };
+
+/* Both calls are inlined.  */
+
+void
+small_to_big (struct big *d, const struct small *s)
+{
+  d->a = s->a;	/* { dg-bogus "outside array bounds" } */
+  d->b = s->b;	/* { dg-bogus "outside array bounds" } */
+  d->c = s->c;	/* { dg-bogus "outside array bounds" } */
+}
+
+void
+big_to_small (struct small *d, const struct big *s)
+{
+  d->a = s->a;	/* { dg-bogus "outside array bounds" } */
+  d->b = s->b;	/* { dg-bogus "outside array bounds" } */
+  d->c = s->c;	/* { dg-bogus "outside array bounds" } */
+}
+
+void
+f (struct big *b)
+{
+  struct small s;
+
+  big_to_small (&s, b);
+  small_to_big (b, &s);
+}
+
+/* Too big to inline into a cold function: the call to the copy goes to
+   the function it was merged into after inlining.  */
+
+void
+redir_1 (struct big *d, const struct small *s)
+{
+  for (int i = 0; i < s->a; i++)
+    {
+      ext (i);
+      ext (s->b);
+      ext (i * s->c);
+      ext (s->a);
+    }
+  d->a = s->a + 2;
+  d->b = s->b;
+  d->c = s->c;
+}
+
+void
+redir_2 (struct small *d, const struct big *s)
+{
+  for (int i = 0; i < s->a; i++)
+    {
+      ext (i);
+      ext (s->b);
+      ext (i * s->c);
+      ext (s->a);
+    }
+  d->a = s->a + 2;
+  d->b = s->b;
+  d->c = s->c;
+}
+
+__attribute__ ((cold)) void
+h (struct big *b, struct small *s)
+{
+  redir_1 (b, s);
+  redir_2 (s, b);
+}
+
+/* { dg-final { scan-ipa-dump {Semantic equality hit:(small_to_big|big_to_small)/[0-9]+->(small_to_big|big_to_small)/[0-9]+} "icf" } } */
+/* { dg-final { scan-ipa-dump {Semantic equality hit:redir_[12]/[0-9]+->redir_[12]/[0-9]+} "icf" } } */
+/* { dg-final { scan-ipa-dump-times {1 local calls go to an inline-only copy} 2 "icf" } } */
+/* { dg-final { scan-ipa-dump {ICF: 1 calls of redir_[12]\.icf\.[0-9]+/[0-9]+ not inlined have been redirected to redir_[12]/[0-9]+} "inline" } } */
diff --git a/gcc/testsuite/gcc.dg/ipa/pr105438-2.c b/gcc/testsuite/gcc.dg/ipa/pr105438-2.c
new file mode 100644
index 00000000000..1ea03255033
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/ipa/pr105438-2.c
@@ -0,0 +1,115 @@
+/* PR ipa/105438 */
+/* { dg-do run } */
+/* { dg-options "-O2 -fno-strict-aliasing -fno-early-inlining" } */
+
+/* The merges of pr105438-1.c, run: calls inlined from the inline-only
+   copies, calls redirected after inlining, and calls through the wrappers
+   give the right results, and the merged functions keep distinct
+   addresses.  */
+
+struct small { char pad[16]; int a; unsigned int b, c; };
+struct big { char pad[16]; int a; unsigned int b, c; int extra; };
+
+int sum;
+
+__attribute__ ((noipa)) void
+ext (int x)
+{
+  sum += x;
+}
+
+void
+copy_1 (struct big *d, const struct small *s)
+{
+  d->a = s->a + 1;
+  d->b = s->b;
+  d->c = s->c;
+}
+
+void
+copy_2 (struct small *d, const struct big *s)
+{
+  d->a = s->a + 1;
+  d->b = s->b;
+  d->c = s->c;
+}
+
+void
+redir_1 (struct big *d, const struct small *s)
+{
+  for (int i = 0; i < s->a; i++)
+    {
+      ext (i);
+      ext (s->b);
+      ext (i * s->c);
+      ext (s->a);
+    }
+  d->a = s->a + 2;
+  d->b = s->b;
+  d->c = s->c;
+}
+
+void
+redir_2 (struct small *d, const struct big *s)
+{
+  for (int i = 0; i < s->a; i++)
+    {
+      ext (i);
+      ext (s->b);
+      ext (i * s->c);
+      ext (s->a);
+    }
+  d->a = s->a + 2;
+  d->b = s->b;
+  d->c = s->c;
+}
+
+__attribute__ ((cold, noipa)) void
+cold_calls (struct big *b, struct small *s)
+{
+  redir_1 (b, s);
+  redir_2 (s, b);
+}
+
+__attribute__ ((noipa)) void
+inlined_calls (struct big *b, struct small *s)
+{
+  copy_2 (s, b);
+  copy_1 (b, s);
+}
+
+void (*volatile p1) (struct big *, const struct small *) = copy_1;
+void (*volatile p2) (struct small *, const struct big *) = copy_2;
+
+int
+main ()
+{
+  struct big b = { .a = 10, .b = 20, .c = 30, .extra = 40 };
+  struct small s = { .a = 1, .b = 2, .c = 3 };
+
+  cold_calls (&b, &s);
+  /* b.a = s.a + 2, after one iteration (i = 0) adding 0 + 2 + 0 + 1;
+     then s.a = b.a + 2, after three iterations (i = 0, 1, 2) adding the
+     sums of i, b.b, i * b.c, and b.a: 3 + 6 + 9 + 9.  */
+  if (b.a != 3 || b.b != 2 || b.c != 3 || b.extra != 40)
+    __builtin_abort ();
+  if (s.a != 5 || s.b != 2 || s.c != 3)
+    __builtin_abort ();
+  if (sum != 3 + 27)
+    __builtin_abort ();
+
+  inlined_calls (&b, &s);
+  /* s.a = b.a + 1, then b.a = s.a + 1.  */
+  if (s.a != 4 || b.a != 5 || b.extra != 40)
+    __builtin_abort ();
+
+  p2 (&s, &b);
+  p1 (&b, &s);
+  if (s.a != 6 || b.a != 7 || b.extra != 40)
+    __builtin_abort ();
+
+  if ((void *) p1 == (void *) p2)
+    __builtin_abort ();
+
+  return 0;
+}
diff --git a/gcc/testsuite/gcc.dg/ipa/pr105438-5.c b/gcc/testsuite/gcc.dg/ipa/pr105438-5.c
new file mode 100644
index 00000000000..54e4b5db4bf
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/ipa/pr105438-5.c
@@ -0,0 +1,98 @@
+/* PR ipa/105438 */
+/* { dg-do compile } */
+/* { dg-options "-O2 -fno-strict-aliasing -fno-early-inlining -Warray-bounds -fdump-ipa-icf-details" } */
+
+/* ICF merges the static functions below.  With symbol aliases, one
+   becomes an alias of the other after inlining; without them, its calls
+   go to an inline-only copy of its body and its own body is removed.
+   Either way the inlined calls get each function's own body, and its
+   types.  */
+
+struct in6 { unsigned int w[4]; };
+
+struct user
+{
+  char name[16];
+  int link;
+  unsigned char proto, encap_limit, hop_limit;
+  unsigned int flowinfo, flags;
+  struct in6 laddr, raddr;
+};
+
+struct kern
+{
+  char name[16];
+  int link;
+  unsigned char proto, encap_limit, hop_limit, collect_md;
+  unsigned int flowinfo, flags;
+  struct in6 laddr, raddr;
+  unsigned int extra[8];
+};
+
+static void
+from_user (struct kern *p, const struct user *u)
+{
+  p->laddr = u->laddr;		/* { dg-bogus "outside array bounds" } */
+  p->raddr = u->raddr;		/* { dg-bogus "outside array bounds" } */
+  p->flags = u->flags;		/* { dg-bogus "outside array bounds" } */
+  p->hop_limit = u->hop_limit;	/* { dg-bogus "outside array bounds" } */
+  p->encap_limit = u->encap_limit; /* { dg-bogus "outside array bounds" } */
+  p->flowinfo = u->flowinfo;	/* { dg-bogus "outside array bounds" } */
+  p->link = u->link;		/* { dg-bogus "outside array bounds" } */
+  p->proto = u->proto;		/* { dg-bogus "outside array bounds" } */
+}
+
+static void
+to_user (struct user *u, const struct kern *p)
+{
+  u->laddr = p->laddr;		/* { dg-bogus "outside array bounds" } */
+  u->raddr = p->raddr;		/* { dg-bogus "outside array bounds" } */
+  u->flags = p->flags;		/* { dg-bogus "outside array bounds" } */
+  u->hop_limit = p->hop_limit;	/* { dg-bogus "outside array bounds" } */
+  u->encap_limit = p->encap_limit; /* { dg-bogus "outside array bounds" } */
+  u->flowinfo = p->flowinfo;	/* { dg-bogus "outside array bounds" } */
+  u->link = p->link;		/* { dg-bogus "outside array bounds" } */
+  u->proto = p->proto;		/* { dg-bogus "outside array bounds" } */
+}
+
+struct kern *locate (struct kern *);
+int get (struct user *);
+int put (const struct user *);
+
+int
+f (int cmd)
+{
+  struct user u;
+  struct kern k = {};
+  struct kern *t;
+
+  switch (cmd)
+    {
+    case 0:
+      if (get (&u))
+	return -1;
+      from_user (&k, &u);
+      t = locate (&k);
+      to_user (&u, t);
+      return put (&u);
+    case 1:
+      if (get (&u))
+	return -1;
+      from_user (&k, &u);
+      t = locate (&k);
+      if (!t)
+	return -2;
+      to_user (&u, t);
+      return put (&u);
+    case 2:
+      if (get (&u))
+	return -1;
+      from_user (&k, &u);
+      return !locate (&k);
+    }
+  return 0;
+}
+
+/* { dg-final { scan-ipa-dump {Semantic equality hit:(from_user|to_user)/[0-9]+->(from_user|to_user)/[0-9]+} "icf" } } */
+/* { dg-final { scan-ipa-dump {Unified; Function alias has been created} "icf" { target alias } } } */
+/* { dg-final { scan-ipa-dump {local calls go to an inline-only copy} "icf" { target { ! alias } } } } */
diff --git a/gcc/testsuite/gcc.dg/ipa/pr105438-6.c b/gcc/testsuite/gcc.dg/ipa/pr105438-6.c
new file mode 100644
index 00000000000..b02c330de30
--- /dev/null
+++ b/gcc/testsuite/gcc.dg/ipa/pr105438-6.c
@@ -0,0 +1,50 @@
+/* PR ipa/105438 */
+/* { dg-do compile } */
+/* { dg-options "-O2 -fdump-ipa-icf-details" } */
+
+/* ICF merges the start pair, sending b_next's call of b_start to an
+   inline-only copy of b_start, and then the next pair, releasing b_next's
+   body and with it the copy's only call.  The copy must be removed before
+   IPA-CP, which ICEd on a local function without calls.  */
+
+void ext (int);
+
+int
+a_start (int x)
+{
+  for (int i = 0; i < x; i++)
+    {
+      ext (i);
+      ext (i * x);
+      ext (x);
+    }
+  return x * 3;
+}
+
+int
+b_start (int x)
+{
+  for (int i = 0; i < x; i++)
+    {
+      ext (i);
+      ext (i * x);
+      ext (x);
+    }
+  return x * 3;
+}
+
+int
+a_next (int x)
+{
+  return a_start (x + 1) + 1;
+}
+
+int
+b_next (int x)
+{
+  return b_start (x + 1) + 1;
+}
+
+/* { dg-final { scan-ipa-dump {Semantic equality hit:[ab]_start/[0-9]+->[ab]_start/[0-9]+} "icf" } } */
+/* { dg-final { scan-ipa-dump {Semantic equality hit:[ab]_next/[0-9]+->[ab]_next/[0-9]+} "icf" } } */
+/* { dg-final { scan-ipa-dump {1 local calls go to an inline-only copy} "icf" } } */
-- 
2.53.0


--9b2nh3KoyAsvLx9k--
