Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530F158DD7;
	Fri, 31 May 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172907; cv=none; b=ZnvkIYzUkY+YZzuvrL6FuawAeP0Yjbbe9vqI9rQO7k+o5Q71REvFv3xfGk9y7bhxN+r/vYbM6zxbL4AaoMs5HZr82y7W8OL1k80e/hkr7XhuBX3sP2PfEOEatTz3ZEmTjuhBnrtUjcIdO1UaVirc5d+Tx8LX0MU+0nXVtDrb+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172907; c=relaxed/simple;
	bh=G9YBmBIaLtAXZPjNyAagf7B6fv+FKzsPzY489k3bd2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYYlLZggJJ2qPZorQOkHFgD+Vm9hqSuKW/aYoVU6B1Fmt/Z2iXLbMQJej0FPiP8KgzyN3yBVCjgwL7AepVgoZN4cG27nEPqrhk0bVJ284gNUfXqRQTl4+hf6bYinU7EMIS7Pxr+10hURT8zQCsJbW7Y4qHI/4fTlC3qC2PDFSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA6mqYpF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA6mqYpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BD9C116B1;
	Fri, 31 May 2024 16:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717172907;
	bh=G9YBmBIaLtAXZPjNyAagf7B6fv+FKzsPzY489k3bd2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tA6mqYpF5paicZvv4vbBxYXrwWg4Vc0trMhm7CIfgnWMnRm9BhL+yS6yqLy3y/otu
	 JSossMlgG5yHYJlcHphb5UiFnccarJ0LeWYyswSJ4JebhPYg2e61p06n4+upaf+Ae5
	 5NnbxbrDZuW6o/FRuQjhCBblw0XCe6zcdJ7m1EO+UmzT5chmuiX4Fag00a0tvvqzrB
	 FvY2L5Q+z00Wy3llSN+DALsqpOY2QvLmvgCUTnAMLeMQOOV5EBMp7KVACEkAI00v7z
	 En3ZmWds/j+hCt1HQ1YTDpyBwEY6eVCclba2DD0rbYg74ZQyWRqp/eXyboixaXNQv5
	 3I6F5qaGhOtsw==
Date: Fri, 31 May 2024 09:28:26 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
Message-ID: <202405310923.78257B2B3@keescook>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>

On Thu, May 30, 2024 at 09:23:36AM -0700, Jeff Johnson wrote:
> On 5/30/2024 8:42 AM, Nikolay Borisov wrote:
> > 
> > 
> > On 29.05.24 г. 21:09 ч., Jeff Johnson wrote:
> >> As discussed in [1] add a prototype for __fortify_panic() to fix the
> >> 'make W=1 C=1' warning:
> >>
> >> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?
> > 
> > Actually doesn't it make sense to have this defined under ../string.h ? 
> > Actually given that we don't have any string fortification under the 
> > boot/  why have the fortify _* functions at all ?
> 
> I'll let Kees answer these questions since I just took guidance from him :)

Ah-ha, I see what's happening. When not built with
CONFIG_FORTIFY_SOURCE, fortify-string.h isn't included. But since misc.c
has the function definition, we get a warning that the function
declaration was never seen. This is likely the better solution:


diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a21c15f..3f21a5e218f8 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -532,7 +532,9 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	return output + entry_offset;
 }
 
+#ifdef CONFIG_FORTIFY_SOURCE
 void __fortify_panic(const u8 reason, size_t avail, size_t size)
 {
 	error("detected buffer overflow");
 }
+#endif


Jeff, can you test this? (I still haven't been able to reproduce the
warning.)

-- 
Kees Cook
