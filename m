Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB0173;
	Thu, 13 Mar 2025 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741824224; cv=none; b=poCCfubl39F5qjbH1nHx45c4N0y60QgJtyOyW76Dz+BsWcbsmqhvcezoyWMvR7uDL4z/2cmsYMDcvOns7Z0lUJKY1cySoiIBBzt4fbtXA5uwiWyeRYO1QqHh9dzC/ymYqRcDxkpyHEiuvph758YDjVUBI7Z/KSlIDFH03BzIKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741824224; c=relaxed/simple;
	bh=UaF7HWD7KnuM/tcxBho4NWWozl24AgWzgEfnWk8w7i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DinV1djc0wWvZLG8obTgh+b1EcwiU4+qI7/U0sIgqumw5EWhX2jAoAMiJsMk/Evwj/VPK+qNUd88zYtcBF1yV0mJre+cQkgf1UZEJjR5fy3+KbR+b13mkUtQxWDPnmAcI1wb0abRNLXC61Z0taYYp0qMNdLSoHMYg/AZp2OP3wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=LZ304NhK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHrjBbMr; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="LZ304NhK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHrjBbMr"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A93B25401B8;
	Wed, 12 Mar 2025 20:03:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 12 Mar 2025 20:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741824219; x=
	1741910619; bh=ivul6aIvs6HSo9qOyouoHkt7QFmrzjtgI/MDUv4pG6o=; b=L
	Z304NhKmwGdc5rucdjKPOPi52lbHQJMxfn1SZkgvxEBOrVY/1DEUPCnIPeMpum8p
	RdP6JmJVd9p6KkSTAtIIrutR1DwTFJm/rWxmdrjL/J2pZ5sZnyAKLAuQzTkQG0xC
	X9vmxY1OsXIJ0mKlOIrt0tYqrmJLpyF5VGcBv1i7RL3vaYBDf82I44dwC9W/QcvO
	30ydPh2NPPrb9LLNF5bqEgdk55H1qo9PS96qpNQ92HkPnR8kLvIkQzkPZHnfIIP8
	3cIvAG3YKFwVtHJDAy/BXt+9KFz9Rf6mhLW+qFvf0TRgQ087XOaXbbo3b7rFqThT
	dbC6tfJYHVxwhJ3qTI9og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741824219; x=1741910619; bh=ivul6aIvs6HSo9qOyouoHkt7QFmrzjtgI/M
	DUv4pG6o=; b=CHrjBbMrj5KOoW9wgEdlWeW5yzK9764GQV0WRT3M1nRqe7kbN9K
	TDWf+Vgygmn0gjkimSIp8vgmOJ38zyc5Ec9mQFqSK7pBnzDy+X5TF3L734VvXLD3
	HFOSpy6lBycHZ/wfvZ3YHz5l+lmusn6x/Nja+h6bQApZJx93cYluu/BOgUvdStUi
	t0bnfbXJsYsSuHOCtQK0QR9/s6XLhYTu9whj2nCrRKnppr12fRbuVNhzr84BqTwh
	p26YEZkeNXoPolv1DzKqg1wMjG9FfpM4edmptpVEPeGz36GGBLMmG5uJDvSizoyh
	7iQdb+B/pj2eV6LTw6Icl9HvXft2k9KKnsQ==
X-ME-Sender: <xms:2yDSZy4cVe9o23idBt2K14fYyLxDHbDHR0KOlFr_aLrCmxtUxLX5BQ>
    <xme:2yDSZ75v7ITufVpYM6UWMXsfL9XSaNB_vQCsSeZcK4pxwI6OxmtoWWFAb4ileXeEP
    uLYT-tSyGCyT-1bYAY>
X-ME-Received: <xmr:2yDSZxegmMPqwZd84hjELVjpwsLtSxLcLzAzevO8ddQVj-fDFCUQNGW-aIaxt7qTcnNGnxl1lwQN5Bdta4e34Md71GU2Q8I5UyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdeigeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghk
    rghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtf
    frrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieeitedvleeftdfg
    feeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehguhhsthgrvhhorghrsheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhi
    shhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhh
    rghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2yDSZ_I_6DOc7d5OeZSTgKgcTBUsHpiXlCaA1WtbiiQw1gykBKPhiA>
    <xmx:2yDSZ2Jqss4ZBDKBjJA1qCQwIduyQxfWKA1sJHGxrrGXR1sAmkP3vg>
    <xmx:2yDSZwz0ydw3T1PGBV_Em6scwqblBu4ZG8GbjUvrgdol0wlY9LZsyg>
    <xmx:2yDSZ6JC7UjNpSviQPhqhd4Mg6x2KMqcFoqe69ITHX2BpnBtPvh-jQ>
    <xmx:2yDSZ7HDU1cWI4dqPqrCQ1pQ3xf9QZm4ohUATzFvzidyE0-pQenGDrGe>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 20:03:38 -0400 (EDT)
Date: Thu, 13 Mar 2025 09:03:35 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] firewire: core: avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250313000335.GA320863@workstation.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
References: <Z9AA9tAbcIcz6BMO@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9AA9tAbcIcz6BMO@kspp>

Hi,

On Tue, Mar 11, 2025 at 07:53:02PM +1030, Gustavo A. R. Silva wrote:
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/firewire/core-cdev.c:1141:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/firewire/core-cdev.c | 42 ++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)

Thanks for the improvement, however I think it includes a slight concern
about the calculation for the length of array.

> diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
> index b360dca2c69e..706b9037faac 100644
> --- a/drivers/firewire/core-cdev.c
> +++ b/drivers/firewire/core-cdev.c
> @@ -1137,10 +1137,7 @@ static int ioctl_queue_iso(struct client *client, union ioctl_arg *arg)
>  	unsigned long payload, buffer_end, transmit_header_bytes = 0;
>  	u32 control;
>  	int count;
> -	struct {
> -		struct fw_iso_packet packet;
> -		u8 header[256];
> -	} u;
> +	DEFINE_RAW_FLEX(struct fw_iso_packet, u, header, 8);

The definition of 'struct fw_iso_packet' is in 'include/linux/firewire.h':

```
$ cat include/linux/firewire.h
...
460 struct fw_iso_packet {
461         u16 payload_length;     /* Length of indirect payload           */
462         u32 interrupt:1;        /* Generate interrupt on this packet    */
463         u32 skip:1;             /* tx: Set to not send packet at all    */
464                                 /* rx: Sync bit, wait for matching sy   */
465         u32 tag:2;              /* tx: Tag in packet header             */
466         u32 sy:4;               /* tx: Sy in packet header              */
467         u32 header_length:8;    /* Size of immediate header             */
468         u32 header[];           /* tx: Top of 1394 isoch. data_block    */
469 };
```

The size of element of 'header' array is 4 byte (= 32 / 8). The original code keeps
256 bytes storage following to the structure. Therefore the 'COUNT' argument of DEFINE_RAW_FLEX()
macro should be 64 (= 256 / 4).

Although the header field is not rarely used by userspace applications
actually and the reduction of kernel stack usage is preferable itself,
it is preferable to keep the compatibility.


Thanks

Takashi Sakamoto
