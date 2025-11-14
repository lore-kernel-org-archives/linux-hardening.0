Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2431A7F1;
	Fri, 14 Nov 2025 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127814; cv=none; b=bV+YPSf5d3QaCd9ItYER+a8UpWSa9mKf2TuLqzOhlbcjZMvAE0pbEsBIrsz6Ek4yBvWvwfmlZ/kADl5PyzPO5kDuKO6ju/6iBL5brbXdntwL3jXgR8cReoIRisMG7DpUO9888sDB20vQQEz6v6lF2HQTXq8bPvkqeANtJHGVan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127814; c=relaxed/simple;
	bh=VKQE+Z3AZL15sPgKuq5na267mmgSjzZKb5bJrnj81DA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XcWf+6npnqJsRgOnTfEq0o/5I3c4wbK8dsO5Q6/2Woas0oD9Qi5T+1TPQvl3VsuLmkpiCk2d5thZXNsSyk3YM6KgB3bbtumyTYykctgtn3YmKS23CvSmX2A0mMXWgJV7WyCzMpvpWuP9LEXyQ2b+t8AH/FkoCRq8UaBLF1Wxcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id A95B64CE5B;
	Fri, 14 Nov 2025 13:43:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id C9ED420011;
	Fri, 14 Nov 2025 13:43:28 +0000 (UTC)
Date: Fri, 14 Nov 2025 08:43:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] unwind deferred: Annotate struct unwind_cache with
 __counted_by
Message-ID: <20251114084346.6469edc0@gandalf.local.home>
In-Reply-To: <20251114122748.222833-1-thorsten.blum@linux.dev>
References: <20251114122748.222833-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C9ED420011
X-Stat-Signature: ch1y4f6yczcigkhiho7payikb1p3tci8
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18WQxqWtFQ1ABePisssVTbi1a7r0ktinLc=
X-HE-Tag: 1763127808-522870
X-HE-Meta: U2FsdGVkX1/rlREy+GM1XZzYXwilyZtHbVKDsLTHLb6s5J/hRoGKc/uVWm8n7CHVpyDF+AoUOTVE8VpXI908iRNqh4LulA58wkF6R6XU0GrTkqJ/e8sp1mb73XsF/z6NC6Yf671NR2HTqTfo6j/fOgaLOFY54h/7vfCAkq2Fbo2UumviClXKUmn+8Byiu1vGvk3+mm14j8ae2butfMCGChPU3nPpqJ/nWaDPFSlAlshAlC2Mirms67Y8FGKgt8FR/cSzfPSH7cEgUfAnxklBQmPGDEzh6lA3cm49vjKH85MLL+UGP3mNpIxcx27dlLn1kYqg2k5sRLH2Mv8TzN1u5SkW/qzTS3lM

On Fri, 14 Nov 2025 13:27:47 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Add the __counted_by() compiler attribute to the flexible array member
> 'entries' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/linux/unwind_deferred_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> index 33b62ac25c86..d4b67f0116f3 100644
> --- a/include/linux/unwind_deferred_types.h
> +++ b/include/linux/unwind_deferred_types.h
> @@ -5,7 +5,7 @@
>  struct unwind_cache {
>  	unsigned long		unwind_completed;
>  	unsigned int		nr_entries;
> -	unsigned long		entries[];
> +	unsigned long		entries[] __counted_by(nr_entries);
>  };
>  
>  /*

Wrong!

I need to add a comment here that entries is not bound by nr_entries.

   https://lore.kernel.org/all/20250730093249.4833be14@gandalf.local.home/

Maybe this?:

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 33b62ac25c86..d05409bb14fa 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -5,7 +5,7 @@
 struct unwind_cache {
 	unsigned long		unwind_completed;
 	unsigned int		nr_entries;
-	unsigned long		entries[];
+	unsigned long		entries[]; /* Fixed size, not bound by nr_entries */
 };
 
 /*



-- Steve
