Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16F14F86
	for <linux-hardening@vger.kernel.org>; Sun, 12 Nov 2023 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alarsen.net header.i=@alarsen.net header.b="Vp705sjF"
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Nov 2023 08:25:05 PST
Received: from mail.alarsen.net (mail.alarsen.net [144.76.18.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CC2702;
	Sun, 12 Nov 2023 08:25:05 -0800 (PST)
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:25a3:8809:d018:f17])
	by joe.alarsen.net (Postfix) with ESMTPS id 8FD2E180EC7;
	Sun, 12 Nov 2023 17:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
	t=1699805792; bh=g29MpB5b2J7H2Cim5OSuRbINZsohURRuZ/RssLR9l/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vp705sjF/Kjn9UkwtwOwlRadzzbX2Gj9t7Nmh4DGucpPfhiE/PgNNmOPUXF9F6DXp
	 EONsSiYXo8g6nCEqgKnv4ZdJQ4aAeA1z/fpFuQUP+kcBFMhm42XtU9CoOtUYz0HxB5
	 ABPr1mHYF00pEnPboUXEK7H+6z1rYTZnbCMYCj4g=
Received: from oscar.localnet (localhost [IPv6:::1])
	by oscar.alarsen.net (Postfix) with ESMTPS id 7939D2B2;
	Sun, 12 Nov 2023 17:16:32 +0100 (CET)
From: Anders Larsen <al@alarsen.net>
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: keescook@chromium.org, gustavoars@kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Niek Nooijens <nieknooijens@gmail.com>
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Date: Sun, 12 Nov 2023 17:16:32 +0100
Message-ID: <2655833.BddDVKsqQX@oscar>
In-Reply-To: <20231112095353.579855-1-debug.penguin32@gmail.com>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On 2023-11-12 10:53 Ronald Monthero wrote:
> qnx4 dir name length can vary to be of maximum size
> QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> 'link info' entry is stored and the status byte is set.
> So to avoid buffer overflow check di_fname length
> fetched from (struct qnx4_inode_entry *)
> before use in strlen to avoid buffer overflow.

[snip]

> 
> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> ---
>  fs/qnx4/namei.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> index 8d72221735d7..825b891a52b3 100644
> --- a/fs/qnx4/namei.c
> +++ b/fs/qnx4/namei.c
> @@ -40,6 +40,13 @@ static int qnx4_match(int len, const char *name,
>  	} else {
>  		namelen = QNX4_SHORT_NAME_MAX;
>  	}
> +
> +	/** qnx4 dir name length can vary, check the di_fname
> +	 * fetched from (struct qnx4_inode_entry *) before use in
> +	 * strlen to avoid panic due to buffer overflow"
> +	 */
> +	if (strnlen(de->di_fname, namelen) >= sizeof(de->di_fname))
> +		return -ENAMETOOLONG;

sizeof(de->di_fname) equals QNX4_SHORT_NAME_MAX, so this test fails as soon as 
a filename is longer than that!

This quick fix (untested!) should do the trick (and avoids computing the length 
of the name twice):

diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..7694f86fbb2e 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -40,9 +40,7 @@ static int qnx4_match(int len, const char *name,
 	} else {
 		namelen = QNX4_SHORT_NAME_MAX;
 	}
-	thislen = strlen( de->di_fname );
-	if ( thislen > namelen )
-		thislen = namelen;
+	thislen = strnlen(de->di_fname, namelen);
 	if (len != thislen) {
 		return 0;
 	}

Cheers
Anders


