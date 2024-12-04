Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAC18C034
	for <linux-hardening@vger.kernel.org>; Wed,  4 Dec 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300301; cv=none; b=c3M/x+xpedz68lI/B3InVfuRQDsiMsNmdVhDoWiGfIPq8ml/jnh7Nud00dGfsABBH/FuaK3hI7KpIC4knQm5VE3iA5U/9KDZNKAaF+I8T0jcaRRchsX5Cg0rEnAu+uODl/5kcIRD8pI4FR2HXMyL7Oewge840gGy+rUcIBvPGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300301; c=relaxed/simple;
	bh=8FpHqnAtGz8H9oAXG4fX5y5jZFGzptv8ylvhWvYsi8U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=X321/gD1vYrVjZLP8byxjjJ77xmLI8K0FV19HLyuqKWskc4x30G3UFlO8dlWnQ+KkZUo9fotW29Hiqe8V5/1voQKsUSAe5VZFe1kslDUBiaAVw2QD4v4dfLx26JJDqn2Dfu2oVRWr1B53lYHIsvTpfEhLyY9RZVAo6ggufVgJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtzjl1cB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtzjl1cB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1CAC4CED1;
	Wed,  4 Dec 2024 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733300301;
	bh=8FpHqnAtGz8H9oAXG4fX5y5jZFGzptv8ylvhWvYsi8U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Dtzjl1cBsC42no2MEA0Yjn4G3AtsWXeetstxzhB65OVMbrkQhiI3gCOyBknrzZy2u
	 K0AppbfrHBNQnrkKi7DSDMQDYJ+TYsyP9MZ2h8FrzPLG6SAy5vgYyGOFJLv1fOMh9C
	 Ek4GgIn1tFd4FaM64S91zCUfiI1FOiZ714efXNS9vYTortwxGa+fA8JYIOZYyIhfJX
	 1tBzvmHrnec6YoHykU2oexgE674eLrIzQRe2HoP1Ezz9RTd1xOFtT+dg7TzFUQegDb
	 b6qMQ5y+gJ98WmdS8ksUovZKfgWMGRwFp6BjEFHRK5fnfZDxsWr7Nb+xNZamluXCwa
	 SQgNNn3Yalhwg==
Date: Wed, 04 Dec 2024 18:18:15 +1000
From: Kees Cook <kees@kernel.org>
To: 15074444048@163.com, linux-hardening@vger.kernel.org
CC: lihaojie <lihaojie@kylinos.cn>
Subject: Re: [PATCH] fortify: Use __struct_size replace __member_size
User-Agent: K-9 Mail for Android
In-Reply-To: <20241204064149.218136-1-15074444048@163.com>
References: <20241204064149.218136-1-15074444048@163.com>
Message-ID: <D39D9DAB-E6DB-451A-92FB-BCF2A388069A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 4, 2024 4:41:49 PM GMT+10:00, 15074444048@163=2Ecom wrote:
>From: lihaojie <lihaojie@kylinos=2Ecn>
>
>Use __struct_size get destination size=2E
>
>Size of destination less of the size to be written will
>make buffer overflow, the size of destination should be
>complete=2E
>

I cannot understand what you mean here=2E Have you encountered a problem w=
here a destination size is incorrectly calculated?

>Signed-off-by: lihaojie <lihaojie@kylinos=2Ecn>
>---
> include/linux/fortify-string=2Eh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/linux/fortify-string=2Eh b/include/linux/fortify-str=
ing=2Eh
>index 0d99bf11d260=2E=2E0504b2c8aab7 100644
>--- a/include/linux/fortify-string=2Eh
>+++ b/include/linux/fortify-string=2Eh
>@@ -277,7 +277,7 @@ extern ssize_t __real_strscpy(char *, const char *, s=
ize_t) __RENAME(sized_strsc
> __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * =
const POS q, size_t size)
> {
> 	/* Use string size rather than possible enclosing struct size=2E */
>-	const size_t p_size =3D __member_size(p);
>+	const size_t p_size =3D __struct_size(p);

No, this must not be done=2E (See the comment immediately above it=2E) We =
must limit the maximum write size to the length of the target buffe, not th=
e enclosing structure that contains it=2E

-Kees

--=20
Kees Cook
