Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180838DC40
	for <linux-hardening@vger.kernel.org>; Sun, 23 Aug 2026 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787496760; cv=none; b=GCwszYE48vQAX2DLIo/2ZdI4RxTegk/+pcKchs0mVjUO6XpKdevzrCtqiLahvvFUE4Xj2jbouxuQmHDYCzPk0quN8oeUY/i5oGCJXiB2q6MRq11DxVsBhNRIIXwwq4+tjBtZVscq20SDShQur6BmT62LbWxrc2PaB9n9E1GJp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787496760; c=relaxed/simple;
	bh=QcpCNU3SIm5me/gk9qSMiLmqII7ih1L2ucvQ0WndoEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cvflbEJbHNrcka571soVrK/v1UiwhSyD4iSXbjFLt+AnoDHcoSfjPgvmIE8Ad+3O1nUJfAOF33iqBMg4IXaHOKwajQoAPBveq6bG0wHTOX/bRyNMjqm0Z++qZazBSw+TNxXC5DZLZAzg42wxozcNlzOdmAwjp4WqWjslCtu/MN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N41T1MWm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N41T1MWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787496757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9tLDeFrxkVsGwwyUZchyB1RpB9Uvos39+na8kp3+EE=;
	b=N41T1MWmdDivXQZw4OpI9I2g7myUW+SB3m2TpnkqNQkSK5hksgR5P+BCxOCRsRJralZ5Kb
	SV9cv7asDq37e5vvc7vjkJc803yi7oQTZNpt/l7p9vCHNfZ1WY0wrU16j4cSsGFbkaU4Zr
	+SZungcyoD+EROssRsGn+p1VjP3O9PI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-hsHQTtU7PVy9zU9euZgomA-1; Sun,
 23 Aug 2026 10:52:32 -0400
X-MC-Unique: hsHQTtU7PVy9zU9euZgomA-1
X-Mimecast-MFC-AGG-ID: hsHQTtU7PVy9zU9euZgomA_1787496750
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF4DB195604C;
	Sun, 23 Aug 2026 14:52:29 +0000 (UTC)
Received: from fedora (unknown [10.44.32.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 472721955F05;
	Sun, 23 Aug 2026 14:52:22 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 23 Aug 2026 16:52:29 +0200 (CEST)
Date: Sun, 23 Aug 2026 16:52:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Alice Ryhl <aliceryhl@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Anand Moon <linux.amoon@gmail.com>,
	codemender-patching+linux@google.com,
	linux-hardening@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 1/2] userns: Add __counted_by_ptr attribute to struct
 uid_gid_map
Message-ID: <aosJJXsQbUUcCDpx@redhat.com>
References: <20260823125155.1136740-1-morbo@google.com>
 <20260823125155.1136740-2-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260823125155.1136740-2-morbo@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: E54tV92sKvCNVS0IW4eZe7-2Y7LAT19nCKz4Zi_hlow_1787496750
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 08/23, Bill Wendling wrote:
>
> The compiler attribute __counted_by_ptr associates a pointer field of a
> struct with a sibling field within the same struct that specifies the
> element count of the allocated memory. This enables KASAN and fortified
> bounds-checking to detect out-of-bounds accesses to the pointer field at
> runtime.
>
> We can add the __counted_by_ptr attribute to the 'forward' and 'reverse'
> pointer fields of 'struct uid_gid_map', which are counted by
> 'nr_extents'. Since 'nr_extents' is defined in a sibling anonymous
> struct inside an anonymous union, the nearest common non-anonymous
> struct level is 'struct uid_gid_map' itself, which is supported by the
> compiler.
>
> However, doing so has runtime implications. In the original
> implementation of insert_extent(), elements are written to
> map->forward[map->nr_extents] before map->nr_extents is incremented:
>
> 	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
> 		dest = &map->extent[map->nr_extents];
> 	else
> 		dest = &map->forward[map->nr_extents];
>
> 	*dest = *extent;
> 	map->nr_extents++;
>
> At the time of writing to 'map->forward[map->nr_extents]',
> map->nr_extents is still 5, but we are accessing index 5 (which is the
> 6th element). Under __counted_by_ptr(nr_extents), the compiler and
> KASAN expect the accessed index to be strictly less than
> map->nr_extents. Therefore, accessing index 5 when the count is 5
> triggers an out-of-bounds panic/trap at runtime.
>
> To resolve this, insert_extent() is refactored to increment
> map->nr_extents first, and then use map->nr_extents - 1 as the index:
>
> 	map->nr_extents++;
> 	if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> 		dest = &map->extent[map->nr_extents - 1];
> 	else
> 		dest = &map->forward[map->nr_extents - 1];
>
> 	*dest = *extent;

I leave this to you and other reviewers (add Alexey), you can safely
ignore my nit.

To me

	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
		dest = &map->extent;
	else
		dest = &map->forward;

	map->nr_extents++;
	dest[map->nr_extents - 1] = *extent;

looks a bit more clear, but this is minor/subjective.

Either way, I think this needs a short comment to explain why do we
need to increment ->nr_extents first, then subtract 1. IOW, to explain
why (say)

	dest[map->nr_extents++] = *extent;

would be wrong.

Oleg.

> Assisted-by: Gemini Next
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Nicolas Schier <nsc@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: "Thomas Weiﬂschuh" <thomas.weissschuh@linutronix.de>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Anand Moon <linux.amoon@gmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: codemender-patching+linux@google.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  include/linux/user_namespace.h | 4 ++--
>  kernel/user_namespace.c        | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index e38d9e60569f..2962256eddf7 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -29,8 +29,8 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
>  			u32 nr_extents;
>  		};
>  		struct {
> -			struct uid_gid_extent *forward;
> -			struct uid_gid_extent *reverse;
> +			struct uid_gid_extent *forward __counted_by_ptr(nr_extents);
> +			struct uid_gid_extent *reverse __counted_by_ptr(nr_extents);
>  		};
>  	};
>  };
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 0bed462e9b2a..7e5371d8f515 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -809,13 +809,13 @@ static int insert_extent(struct uid_gid_map *map, struct uid_gid_extent *extent)
>  		map->reverse = NULL;
>  	}
>  
> -	if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
> -		dest = &map->extent[map->nr_extents];
> +	map->nr_extents++;
> +	if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
> +		dest = &map->extent[map->nr_extents - 1];
>  	else
> -		dest = &map->forward[map->nr_extents];
> +		dest = &map->forward[map->nr_extents - 1];
>  
>  	*dest = *extent;
> -	map->nr_extents++;
>  	return 0;
>  }
>  
> -- 
> 2.55.0.860.g4b6b3295ed-goog
> 

