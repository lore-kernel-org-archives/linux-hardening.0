Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B92632E6A2;
	Fri, 14 Nov 2025 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135627; cv=none; b=PdQCGR/W54yKE0A05Fforr9bpldpo3EpWreRuENobKYCgx5czGISMMRjo4w8bTyeGLtdRdHZNvkwxc2xiG1ruxaDw29zr+wsfu3NBBnwfqC2zCFtdY2s6uSzgilp+vvGddOTMdppVxZ7e8PAt+AalLNXQGjIs3XkltBAEdPYJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135627; c=relaxed/simple;
	bh=7K3SP1pUeSBBCp0KbFNwVIgHV9wBsi9VrPGMcMMrFhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/kAmkcqgmx9pst/7EkgeWfZWjP/tiWnmQgEN65cbjeeybsCv080n6xs63aTnBGHc3oyp9yv53p2xYLGMlFFk89IKy2CghDnxoZR8Hy/wLUrQ2Rxn3lhgt0CB8E6+MQVyt+igtqG2f0mzxuEJ84MpuDP89ge90DpTMdFSqcEIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id BF713B91AF;
	Fri, 14 Nov 2025 15:53:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id D9B3620024;
	Fri, 14 Nov 2025 15:53:41 +0000 (UTC)
Date: Fri, 14 Nov 2025 10:53:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] unwind deferred: Annotate struct unwind_cache with
 __counted_by
Message-ID: <20251114105359.58512d84@gandalf.local.home>
In-Reply-To: <20251114104952.045805af@gandalf.local.home>
References: <20251114122748.222833-1-thorsten.blum@linux.dev>
	<20251114084346.6469edc0@gandalf.local.home>
	<20251114143104.0d1aead3@pumpkin>
	<20251114095644.116a767d@gandalf.local.home>
	<20251114104952.045805af@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D9B3620024
X-Stat-Signature: t1gexbh7am8wrg9y4txrnzdj6azdsigt
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//e7vtrf/uvd26T/qmRWbZ4HuxvehLS1I=
X-HE-Tag: 1763135621-980771
X-HE-Meta: U2FsdGVkX1/POr+EGOzEVlgOvRCC78uxBraCZc+hh8CTtHjlso1UvVz1gFs3KQGnAVzE0jHDFgmb3XDyF9f4fdUGxSa1aPYMTMlgXyea2Inck3zFfLwHQQseKY1IKOaDHtEFZ1zistZtHbsI5xcpwIV789x2K8unz2XLpT1deLV5oMJyS1yPGeviPsTC/KtU3xInG3bvixMQXGwrjWcsM4AvKtAjmjSh5E9AszXljxwCApZ0iSdUkp+ZUJCKMxnA6y1By/kWWJJjVqSNZi/TB24EDNdW5szS9UrOyhIv/Rp8M9VrLjDyHCknO8vwHlvgMScOcGJSDA9TBQS1yc6Og6A4ty7i21+6Mf1l76r8q/aLYyBkiL1mFl+kFM5QW7Y36cLIg8BFlF9Ioe8poqTBuZbezO6ygNtl

On Fri, 14 Nov 2025 10:49:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 14 Nov 2025 09:56:44 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > >     
> > > >  	unsigned int		nr_entries;
> > > > -	unsigned long		entries[];
> > > > +	unsigned long		entries[]; /* Fixed size, not bound by nr_entries */
> > > >  };      
> > > 
> > > Perhaps it should be:
> > > 	unsigned long entries[ /* MAX_UNWIND_ENTRIES */ ];    
> > 
> > Whatever would keep the coccinelle folks from sending more patches.  
> 
> Thorsten,
> 
> Which comment would you feel is more obvious that entries is not bound by
> nr_entries and prevent this patch from being sent again?
> 

Or we can simply move the macro to the header:

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 18fa3932f61c..0e43556b9710 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -5,10 +5,14 @@
 #include <linux/types.h>
 #include <linux/atomic.h>
 
+/* Make the cache fit in a 4K page */
+#define UNWIND_MAX_ENTRIES					\
+	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
+
 struct unwind_cache {
 	unsigned long		unwind_completed;
 	unsigned int		nr_entries;
-	unsigned long		entries[];
+	unsigned long		entries[ /* UNWIND_MAX_ENTRIES */ ];
 };
 
 /*
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index a88fb481c4a3..6ea7cb5f336d 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -37,10 +37,6 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 }
 #endif
 
-/* Make the cache fit in a 4K page */
-#define UNWIND_MAX_ENTRIES					\
-	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
-
 /* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);


-- Steve
