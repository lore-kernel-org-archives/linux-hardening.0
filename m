Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E71DF246
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188015; cv=none; b=NrnetrblOhw7EftDK9Y1EE5nKbMF3Zc0gIXupobPAfyFIF2g53u8YwNhXZy4TrPU+h1PYE034DpWFKM85bG+kLP2HEk0b999wEzc1EOoB+6/+aIJUTmAsJ2y2zHFEXGPMRiEvIOmz9VpaUHgkcR3PNL0vep9rqg+ceK9zM5gnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188015; c=relaxed/simple;
	bh=KZauAlwh3gioS2gCxSx+TZiDN4jSePDEnO/bMXwfq28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcOUUh16R1OF+ypAg8lZc2gEPIKASnMy33dQGIJ7B1KR6xAfBInuAKcLko4SPcfEDiSwp8qB6e267+RR1oQ6HMnzrwzYhLv50c+NqdpBZ9isYX5VmhOME65Yfk9qidpVLN16MTbg77uELGOHdroMeUFcH7jGJKZGH4CDAlevI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYlq8i7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYlq8i7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2B9C4CEC3;
	Thu, 17 Oct 2024 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729188014;
	bh=KZauAlwh3gioS2gCxSx+TZiDN4jSePDEnO/bMXwfq28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYlq8i7kT4GGxu9R4TAVdqDfFRIOw6JnpvdLUL+ndqSYqxfbZUhrjsCevGJqZ9Zh7
	 fos+mzsEaVAMS+5EzpkfIHxPzoCBU8QXk8Idbls5dxtFJok6szvGNki3g//JMrebC2
	 L54cGe669cF/FPfSc6D1y+IfKLwp37NRxvtgcWpB9ad964W55oHJDCbNhjLmatpOHS
	 3lQClEaooV2ManwWfG2utRHORBEvPT81sGL5Kuvi/KlsQPrLTMOFnBNFOmJX/jFw3J
	 6w/SllahrdMy6/Na3Lqqpel/zndiGn4XKxBm8j2bGWVauHkqxwOrdoZaZEvyk90kMq
	 iSWj9cCldSijw==
Date: Thu, 17 Oct 2024 11:00:11 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: Fwd: [linux-next:master 4380/4439]
 include/linux/fortify-string.h:293:17: error: call to '__write_overflow'
 declared with attribute error: detected write beyond size of object (1st
 parameter)
Message-ID: <202410171059.C2C395030@keescook>
References: <202410171420.1V00ICVG-lkp@intel.com>
 <CAHC9VhQasYp3dkv5Mx4uEy7ZmtYWywU2wJrto_xvUAjgScXL5w@mail.gmail.com>
 <202410170847.F6C111256F@keescook>
 <202410170922.0B55ABC@keescook>
 <202410170946.C3D7594@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410170946.C3D7594@keescook>

On Thu, Oct 17, 2024 at 09:48:18AM -0700, Kees Cook wrote:
> On Thu, Oct 17, 2024 at 09:23:25AM -0700, Kees Cook wrote:
> > On Thu, Oct 17, 2024 at 09:07:13AM -0700, Kees Cook wrote:
> > > Something in the .config is causing the error. (!?) I will start a
> > > CONFIG bisect...
> > 
> > Well, I did a code bisect first, and it reported this which makes _no_
> > sense:
> > 8afd8c8faa24 ("lsm: remove lsm_prop scaffolding")
> > 
> > O_o
> 
> Looks like a GCC inlining bug. If I query the size of the destination
> buffer before calling strscpy the warning magically vanishes. :|
> 
> Lovely. I will see if I can construct a work-around.

I am extremely bothered that this fixes it:

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index bc052b4b5a1d..891f4294361d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2728,8 +2728,8 @@ void __audit_ptrace(struct task_struct *t)
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getlsmprop_obj(t, &context->target_ref);
 	strscpy(context->target_comm, t->comm);
+	security_task_getlsmprop_obj(t, &context->target_ref);
 }
 
 /**
@@ -2755,8 +2755,8 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getlsmprop_obj(t, &ctx->target_ref);
 		strscpy(ctx->target_comm, t->comm);
+		security_task_getlsmprop_obj(t, &ctx->target_ref);
 		return 0;
 	}
 

I will continue trying to figure out why GCC is getting confused here,
but in the meantime, perhaps this is a viable workaround?

-- 
Kees Cook
