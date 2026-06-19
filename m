Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D813367B81;
	Fri, 19 Jun 2026 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866710; cv=none; b=tGNkEs6cOaL9BJebHqeQx5HGpEywZMachzytM3B6/88b6QMGpo8AdBad/GXodJtI4jC1kKMg850v71sy4ei3emsTyjSMw6SGkimV3ibMpFQNjNSqZ3DHBVWpUpQBWecVr54QEQWfNa+kE+YMRO2eMclp+jog9IHkz88RmWI6C/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866710; c=relaxed/simple;
	bh=ihPOxA23HSbTwQkRxJoVCMpNcLb890VF+31HNcQ993U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B47FXLnZ4fL7v8+TsNuVC5KjZnPvdmG4cVqK6z4yKgn6VC2w9lhNP0D8PLNWR+JrnTbgHSk3CH+x4zeYueKDvq7kTTOCOZFLharR8yLor4dR7jDMspnSEJk5wn8H1EOMByQ43kZd7a/do4FgoaYjMhxUx6MWY3cC9jWpPiZq7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS6mI0y+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS6mI0y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67251F000E9;
	Fri, 19 Jun 2026 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781866709;
	bh=twUEhYBIY69tw/9ksVydy3IbJ+fWcrJ0sUspGHdmwwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CS6mI0y+P5iaF+Mu7CG7vyheAk3dlK+DN4b3kJBDwMDAHfcF3uwa1ihc1eMI1mGhu
	 cjg6aHk21V8Hbjat0VKXH7tHQAKK2RB+b3ajHVY1KNVeMVpiZWfTuOL/9MfybtxWpF
	 9I1AthJz4sAWMF83NUi5Ya1jt8WRq2jmEjiPDxLVK4OusMuLOSN8ehxgJq/fMidfAt
	 gY28lNXeNhl4tV4rAQFAGah8GSbh+rfqWKR7KT7XQzSyYFdyVlAKt8nmLqJp4Q7zWK
	 wSdaXA0V6iPY9HNrYh2r8uIKdCbDqok95ANfx83hYhvjh4rnrY0OCNSKlQAL3ZCelL
	 OkxWumtLJ808Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH next] fs: Replace strcpy(s, "../") with memcpy(s, "../", 4)
In-Reply-To: <20260606202633.5018-5-david.laight.linux@gmail.com>
References: <CnPdNyUGjsYpAP8JdysfUf4wkBkm2a923cQ1hE4-mg0sUnJIm4Uj-cAkdVHswEsuZ3d6vhmX5eil2zLmrkfl3A==@protonmail.internalid>
 <20260606202633.5018-5-david.laight.linux@gmail.com>
Date: Fri, 19 Jun 2026 12:58:20 +0200
Message-ID: <874iiyg5kj.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<david.laight.linux@gmail.com> writes:

> From: David Laight <david.laight.linux@gmail.com>
>
> The code has already checked there is enough room.
> Use memcpy() to avoid compiler warnings from possibly unbounded strcpy().
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
>
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
>
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
>
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
>
> Note that all the changes are only compile tested.
>
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
>
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
>
>  fs/configfs/symlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> index f3f79c67add5..9f36699e5922 100644
> --- a/fs/configfs/symlink.c
> +++ b/fs/configfs/symlink.c
> @@ -67,7 +67,7 @@ static int configfs_get_target_path(struct config_item *item,
>  	pr_debug("%s: depth = %d, size = %d\n", __func__, depth, size);
>
>  	for (s = path; depth--; s += 3)
> -		strcpy(s,"../");
> +		memcpy(s, "../", 4);

I don't think this transform makes sense when copying string literals.
The post transform code has one more foot gun than the original code.

Best regards,
Andreas Hindborg



