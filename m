Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF43F9C5
	for <linux-hardening@vger.kernel.org>; Sat, 30 Nov 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732951369; cv=none; b=QoOsvNJ1Id9/ca7ishOZPCKOj4ItPwSBbEPvljpJJyyxVO5h2jWLRTofjvYvmwYTHdO2RK01v7w/WK+231E6BvKIcepWz8Qz7Jv65Q+A2LmKIK5xuRHQaI+0f9LgppUdDcxr6CM2XFAEI32g04eqRHigcLb5RvZxnO68qjalyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732951369; c=relaxed/simple;
	bh=ZuGzMu1cAhdhKnxWmpQYt48/+C2Q2jjl167J8oEkP9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWExQODSm8QRgyzJUKsWWO0zLzktRQt0W4q+5uabSp+0QdWiHTW2bWp4jGeTj94pybazdkeVUg46IUb5UXRAKWN0rYGUSq/OuYTfxehqeQRvVHmy+yxRgrDZ2uK8f3uGVEtb/yedBwdWqiSKdaUmV+3nfGGOgkzD3L3txhzJCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gThnyeHU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gThnyeHU"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so2855009a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 29 Nov 2024 23:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732951365; x=1733556165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SjT13Cv4AdQa2fEkQJmI8w/5/0E5OcwQAJoY5vQggB4=;
        b=gThnyeHUPyf6Yoq+wFnU0dS3xGn9DUfh7BjzcS1z+jB0WKlxQre9WXD6SFJvIMgpkd
         TsYKRGpPoC2n3LtoOIGGuFDh1V0Oq0zNWPPKplY5gLKrp0pXp4+uVKP1bvyNaDZP56Dr
         9Ojt0JE03Pngwl8Gl/LfdlE0SO3kjQpAgdUYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732951365; x=1733556165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjT13Cv4AdQa2fEkQJmI8w/5/0E5OcwQAJoY5vQggB4=;
        b=DKS380bwl8UbalKWoNgea5nWrJX53tC/RT5I8Tp4OSMRvU5enhxykuGYIRcwiaJR1z
         Lmu+tSk1G71x0SBBX8PTjog2t/QJ8h0tBdcrSeoHKT9NSyc+ZHXdDzkBQOZFCCqQJLQr
         h4pFZVDv3QGZqshfwDXhLDBlWikUjMg3exc4GWWAPjd6v5jvYVmU8cwi3unQYTwKzV3Q
         GPLbqV3dx8D8k5reDD2ukEXoeKjWrWPmmnkfrYylrokvfCH0R5lal1Bt/lOMwa3lYnMN
         /hduCQZJ1k9sAH5WsoXBEACEycpP/MHyav90KtuuWXO9jOZBo9I1HUxPLuXnOwEKZOF8
         5+nA==
X-Forwarded-Encrypted: i=1; AJvYcCUbnEaRCsXv2KrDnbQ3iycWYxmeJ/mKSuBTj/r5rWmc17JqyimP7ZEDcb//5FkSt5cI4R6Xuvyw9uP2fY2CCOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9OPlLat1RATVt7/izFxEFK325pGbAQqepA5WiZOMz8JGTREy
	lMNdxrpMWDARW4zkOXyn/kQVYwplVzf9nWQVFOsiWFO4NpULTHaah8OLOXInO/nOBmAchCuz7Ci
	o5oW1tA==
X-Gm-Gg: ASbGncs1SzW9ub4Ftilr8nvtu3dx6vKjInEBW0z5hOvuW2EcisHFxXSeoAR/RrvF5AA
	Bf/cqRLAXiybmSQNvrSpiz7U6eeV34sgN7vXgIKKcA+YODKPQXeaMZFnPw5G3FO6XQH2KfbA/FT
	KcNHd2weStTYpHDL3WgtxnfqcYVW8TYdQ3YROIaD1bxKILtUfy6t6GiPczwtCYUeDtsLKsemhCN
	nfqfOmm+PFDekT9pHISeTs6gRDE2QuIpa8V7fdCWZINF3o0euHL+Le/7g712S++M41J9K0Meq56
	vm/VaBZiumChaiIjKLnI0Eis
X-Google-Smtp-Source: AGHT+IFYBdDxLeXmQ9PUk/YW8+ehue+ieQqiu8xEtC4OLxmfjVpDK5h51QHRyJPY7lCzlr2hVVy0uQ==
X-Received: by 2002:a17:906:4590:b0:a99:4136:5b07 with SMTP id a640c23a62f3a-aa581093831mr1030354766b.60.1732951365221;
        Fri, 29 Nov 2024 23:22:45 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d574fsm252023266b.58.2024.11.29.23.22.44
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 23:22:44 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso23163955e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Nov 2024 23:22:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVc849o5RsMNhj8ITFVsvjqJMSRStdy1os5OFYsgAxHaOBsd9nc+j0YGY7yF/nwga7kQ7BcyE21piVyEwcSZQc=@vger.kernel.org
X-Received: by 2002:a17:907:7758:b0:aa5:3d75:f419 with SMTP id
 a640c23a62f3a-aa580f2af8bmr1208100366b.13.1732950961012; Fri, 29 Nov 2024
 23:16:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130044909.work.541-kees@kernel.org>
In-Reply-To: <20241130044909.work.541-kees@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Nov 2024 23:15:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
Message-ID: <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Yu <yu.c.chen@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007218e906281c16e8"

--0000000000007218e906281c16e8
Content-Type: text/plain; charset="UTF-8"

Edited down to just the end result:

On Fri, 29 Nov 2024 at 20:49, Kees Cook <kees@kernel.org> wrote:
>
>  void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
>  {
>         size_t len = min(strlen(buf), sizeof(tsk->comm) - 1);
>
>         trace_task_rename(tsk, buf);
>         memcpy(tsk->comm, buf, len);
>         memset(&tsk->comm[len], 0, sizeof(tsk->comm) - len);
>         perf_event_comm(tsk, exec);
>  }

I actually don't think that's super-safe either. Yeah, it works in
practice, and the last byte is certainly always going to be 0, but it
might not be reliably padded.

Why? It walks over the source twice. First at strlen() time, then at
memcpy. So if the source isn't stable, the end result might have odd
results with NUL characters in the middle.

And strscpy() really was *supposed* to be safe even in this case, and
I thought it was until I looked closer.

But I think strscpy() can be saved.

Something (UNTESTED!) like the attached I think does the right thing.
I added a couple of "READ_ONCE()" things to make it really super-clear
that strscpy() reads the source exactly once, and to not allow any
compiler re-materialization of the reads (although I think that when I
asked people, it turns out neither gcc nor clang rematerialize memory
accesses, so that READ_ONCE is likely more a documentation ad
theoretical thing than a real thing).

And yes, we could make the word-at-a-time case also know about masking
the last word, but it's kind of annoying and depends on byte ordering.

Hmm? I don't think your version is wrong, but I also think we'd be
better off making our 'strscpy()' infrastructure explicitly safe wrt
unstable source strings.

          Linus

--0000000000007218e906281c16e8
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m43u8l1f0>
X-Attachment-Id: f_m43u8l1f0

IGxpYi9zdHJpbmcuYyB8IDE0ICsrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYi9zdHJpbmcuYyBiL2xp
Yi9zdHJpbmcuYwppbmRleCA3NjMyN2I1MWUzNmYuLmEyYTY3OGU0NTM4OSAxMDA2NDQKLS0tIGEv
bGliL3N0cmluZy5jCisrKyBiL2xpYi9zdHJpbmcuYwpAQCAtMTM3LDcgKzEzNyw3IEBAIHNzaXpl
X3Qgc2l6ZWRfc3Ryc2NweShjaGFyICpkZXN0LCBjb25zdCBjaGFyICpzcmMsIHNpemVfdCBjb3Vu
dCkKIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfS01TQU4pKQogCQltYXggPSAwOwogCi0Jd2hpbGUg
KG1heCA+PSBzaXplb2YodW5zaWduZWQgbG9uZykpIHsKKwl3aGlsZSAobWF4ID4gc2l6ZW9mKHVu
c2lnbmVkIGxvbmcpKSB7CiAJCXVuc2lnbmVkIGxvbmcgYywgZGF0YTsKIAogCQljID0gcmVhZF93
b3JkX2F0X2FfdGltZShzcmMrcmVzKTsKQEAgLTE1MywxMCArMTUzLDEwIEBAIHNzaXplX3Qgc2l6
ZWRfc3Ryc2NweShjaGFyICpkZXN0LCBjb25zdCBjaGFyICpzcmMsIHNpemVfdCBjb3VudCkKIAkJ
bWF4IC09IHNpemVvZih1bnNpZ25lZCBsb25nKTsKIAl9CiAKLQl3aGlsZSAoY291bnQpIHsKKwl3
aGlsZSAoY291bnQgPiAwKSB7CiAJCWNoYXIgYzsKIAotCQljID0gc3JjW3Jlc107CisJCWMgPSBS
RUFEX09OQ0Uoc3JjW3Jlc10pOwogCQlkZXN0W3Jlc10gPSBjOwogCQlpZiAoIWMpCiAJCQlyZXR1
cm4gcmVzOwpAQCAtMTY0LDExICsxNjQsMTEgQEAgc3NpemVfdCBzaXplZF9zdHJzY3B5KGNoYXIg
KmRlc3QsIGNvbnN0IGNoYXIgKnNyYywgc2l6ZV90IGNvdW50KQogCQljb3VudC0tOwogCX0KIAot
CS8qIEhpdCBidWZmZXIgbGVuZ3RoIHdpdGhvdXQgZmluZGluZyBhIE5VTDsgZm9yY2UgTlVMLXRl
cm1pbmF0aW9uLiAqLwotCWlmIChyZXMpCi0JCWRlc3RbcmVzLTFdID0gJ1wwJzsKKwkvKiBGaW5h
bCBieXRlIC0gZm9yY2UgTlVMIHRlcm1pbmF0aW9uICovCisJZGVzdFtyZXNdID0gMDsKIAotCXJl
dHVybiAtRTJCSUc7CisJLyogUmV0dXJuIC1FMkJJRyBpZiB0aGUgc291cmNlIGNvbnRpbnVlZC4u
ICovCisJcmV0dXJuIFJFQURfT05DRShzcmNbcmVzXSkgPyAtRTJCSUcgOiByZXM7CiB9CiBFWFBP
UlRfU1lNQk9MKHNpemVkX3N0cnNjcHkpOwogCg==
--0000000000007218e906281c16e8--
