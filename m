Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462E30CDB6
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281934; cv=none; b=kcK8GmmA2I9P2HqREBdW0/iDHiR+XGFd/n7Goq6bYUqQ8swL9YoGfRdocvKskpJh8skC8thkQrLJyp80CS9H+YS7hPw1nkAuHkEy1QBfARLbh+lwTpUjYki9GiNYciVdIATaFhqgw9mLTAHdkgRz+cyM1kudL7RSAkVElmhoAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281934; c=relaxed/simple;
	bh=dpkJh4eWo0NNOQOst2hZvRoTlNGuJSATaj2LFfZj978=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwoCdQ5AO5oMwEIQViE0b7lv15ofBSnnNS+QvhpYrKgGuLjImFySHBpS5YL5D8H2Y2qydsXH3vHdw1JAX5ItIr+dsgCD5yWpyycV6WrXiAsM4JtgTqaOpVqjNDj0xFv7fEK0f6PxxJfJanjQm+PicttZW7Lhhk0S+vsoM8/cjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1G/xUwA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1G/xUwA"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-449de065cb3so4474521f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779281931; x=1779886731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGggALgHzCoPtLdgY/KCVV2cuvNqQvvmKNTA2nt3QnI=;
        b=h1G/xUwAcQTGBt8lP9jW8tA8x0OE1cDdYxD9SBo3EqroOQeFA7ojwHg0oVzbktvs4c
         MB88sodmdKj2Wh8llBPsr6ngoauGCSEznrwDEiFHZJhY8m61E09zYX9NHjLJ7jb+D+bT
         +1YElgY/cNzyVBq7DnKBotcQkoAlvUZC/rYSfzGLlsfIV6Il6ErfQPloMOr2IPKjQaM6
         vw0HOr1C6LtItLUyAp4c66OxCtJz0W6c2BdANGWBOHUnkwKLEkcifGRMLPfYtki0ZXzf
         N/jYeFq1anmoWsdHfqesVqnSH67q+fXJlWPyn4oo7O3wQuzV+nWQDr3KcNLbQgIKuaJ4
         ESAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779281931; x=1779886731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qGggALgHzCoPtLdgY/KCVV2cuvNqQvvmKNTA2nt3QnI=;
        b=F8KUkBWYHmjL9PJ5T2SpkpQD1SoaCOx+fp9nwiOX9SldY+zET1w3KVVqY+ycEXonEY
         R85j6aVVdkshmxroQHsqU6KbkeA56HICmyzPLwOW66pFLl4AuEXbYf3qxjrMYp8sqXDL
         VQTirdRCIV9Sy+ee9l9w7aIDK+wLtbUmKPZi9wxjSIyFgRFGQp2p/8lnVYZ9DvR8G6qB
         xL2JlAoC3nK8S3Z1zrqibq2JSiSC0TCp6VNBI7Ll9mWrSr4L/BIy+PSuc6v8RzW+DWQV
         WTdL60MCyExjn2OhYa9w5YudP552zdArL5slAMuOxNH6LR1/BrcHtpN8/Ua8D4siYjra
         H4AA==
X-Forwarded-Encrypted: i=1; AFNElJ/wauvs4FJppQSzL9UaZYPyWd6VTNN686Ns8HWdULSp+ScaYqFLQxVC8qL7mkFBfpgPgzGHes66cW4nL7Noebg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuEx95XubPDdIJ0lxc+G4BGwwxh2H9PHUNvuM34n9lrfnyW6I2
	BLsqWsBqigbf15I9jhXgibkoG7DN0gCvKDbnvlbIRbRIbo90yYq/Ctuv
X-Gm-Gg: Acq92OFkvgQdwyMPvOVaWkHqFyGulgjfX5BKrAFqDT3XYQRlLaMb91yYgUCTv81v4sF
	h30yMPP/PCZqOFxKsbAu/GTuOPZasS5NSbFY5WG/rw+dR+5wwG56et125Xl+VYBC2dOv3fmQQPP
	uxL/YJv45H/J3HiRoT4yyqpZvy4Ms2kb0y7eOZ62rDTErtHVo812ilcz45tdf8viRkBnDqPf9+K
	TeWstkgvpEd5BGjGnLM4j+WJkkn/SIAY+6DH1gWBg74vUDLH9NTv6Lo0LC+Z6QAWTt+cUpgKudr
	fG+wPMlEj0MC2L5kwfn4jZNBPYeIc2BIYceIFgZem+wdlTS3DpfzrfW0DpBeUXCWiKJ3rR4LIR4
	4ksCvRLAleEo847O3epArWdi+KHbzlBXR8t+aiZ2932br0mAfqLmz4fEsud66SilTptXWEXu8F5
	Q6+CzpvJO7xmiOxkwcyuSdBuu+M1yeqjzTCdWEk5g05PdmaVlRjGA2X4C/vp31p8Dp
X-Received: by 2002:a05:6000:4011:b0:45d:41e0:467b with SMTP id ffacd0b85a97d-45e5c57d3b5mr38701966f8f.3.1779281930642;
        Wed, 20 May 2026 05:58:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm58513115f8f.10.2026.05.20.05.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:58:50 -0700 (PDT)
Date: Wed, 20 May 2026 13:58:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, Nilesh Javali
 <njavali@marvell.com>, Himanshu Madhani <himanshu.madhani@oracle.com>,
 Shyam Sundar <ssundar@marvell.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@kernel.org>, John Meneghini <jmeneghi@redhat.com>,
 Bryan Gurney <bgurney@redhat.com>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Kees Cook
 <kees@kernel.org>, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] scsi: scsi_transport_fc: widen FPIN pname walker
 counter to u32
Message-ID: <20260520135848.6df9f7d2@pumpkin>
In-Reply-To: <20260519190615.2761667-1-michael.bommarito@gmail.com>
References: <20260518143706.2808177-1-michael.bommarito@gmail.com>
	<20260519190615.2761667-1-michael.bommarito@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 15:06:15 -0400
Michael Bommarito <michael.bommarito@gmail.com> wrote:

> An adjacent Fibre Channel fabric actor that can deliver an FPIN ELS
> frame to an lpfc or qla2xxx Linux initiator can trigger a non-return
> in the generic FC transport. This is not a local userspace or IP
> network path; the attacker must be able to inject fabric traffic, for
> example as a compromised switch or fabric controller, or as a same-zone
> N_Port on a fabric that permits source spoofing.
> 
> The Link-Integrity and Peer-Congestion FPIN walkers used a u8 loop
> counter against the 32-bit on-wire pname_count field, and did not bound
> pname_count by the descriptor body already validated by the TLV walker.
> A pname_count of 256 therefore wraps the counter and keeps the loop
> condition true indefinitely.
> 
> Factor the shared pname_list[] walk into one helper, widen the counter
> to u32, and clamp pname_count against the entries that fit in the
> descriptor body before iterating.
> 
> Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Changes in v3:
> - State the fabric-adjacent threat model explicitly in the commit
>   message and clarify that this is not local userspace or IP-network
>   reachable.
> - Use min_t(u32, ...) for the pname_count clamp, as Christoph suggested.
> - Use FC_TLV_DESC_LENGTH_FROM_SZ() instead of open-coding the descriptor
>   body length calculation.
> - Factor the duplicate LI and peer-congestion pname walker into a common
>   helper while preserving the LI-only host-stat update.
> 
> Changes in v2:
> - Drop the redundant cover letter shipped with v1.  A single-patch send
>   does not need one, and the v1 cover carried stale draft markers.
> 
>  drivers/scsi/scsi_transport_fc.c | 77 +++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
> index dce95e361daf0..0684d8c69c3c6 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -737,6 +737,37 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
>  	}
>  }
>  
> +static void
> +fc_fpin_pname_stats_update(struct Scsi_Host *shost,
> +			   struct fc_rport *attach_rport, u16 event_type,
> +			   u32 desc_len, u32 fixed_len, u32 pname_count,
> +			   __be64 *pname_list,
> +			   void (*stats_update)(u16 event_type,
> +						struct fc_fpin_stats *stats))
> +{
> +	u32 i, max_count;
> +	struct fc_rport *rport;
> +	u64 wwpn;
> +
> +	if (desc_len < fixed_len)
> +		max_count = 0;
> +	else
> +		max_count = (desc_len - fixed_len) / sizeof(pname_list[0]);
> +	pname_count = min_t(u32, pname_count, max_count);

No min_t() please, everything is unsigned so min() in fine.
The above might even more readable without the extra variable:
	if (desc_len < fixed_len)
		pname_count = min(pname_count, (desc_len - fixed_len) / sizeof(pname_list[0]));

If you think the line is too long s/pname_count/count/g

-- David

> +
> +	for (i = 0; i < pname_count; i++) {
> +		wwpn = be64_to_cpu(pname_list[i]);
> +		rport = fc_find_rport_by_wwpn(shost, wwpn);
> +		if (rport &&
> +		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
> +		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
> +			if (rport == attach_rport)
> +				continue;
> +			stats_update(event_type, &rport->fpin_stats);
> +		}
> +	}
> +}
> +
>  /*
>   * fc_fpin_li_stats_update - routine to update Link Integrity
>   * event statistics.
> @@ -747,13 +778,11 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
>  static void
>  fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
>  {
> -	u8 i;
>  	struct fc_rport *rport = NULL;
>  	struct fc_rport *attach_rport = NULL;
>  	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
>  	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;
>  	u16 event_type = be16_to_cpu(li_desc->event_type);
> -	u64 wwpn;
>  
>  	rport = fc_find_rport_by_wwpn(shost,
>  				      be64_to_cpu(li_desc->attached_wwpn));
> @@ -764,22 +793,11 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
>  		fc_li_stats_update(event_type, &attach_rport->fpin_stats);
>  	}
>  
> -	if (be32_to_cpu(li_desc->pname_count) > 0) {
> -		for (i = 0;
> -		    i < be32_to_cpu(li_desc->pname_count);
> -		    i++) {
> -			wwpn = be64_to_cpu(li_desc->pname_list[i]);
> -			rport = fc_find_rport_by_wwpn(shost, wwpn);
> -			if (rport &&
> -			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
> -			    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
> -				if (rport == attach_rport)
> -					continue;
> -				fc_li_stats_update(event_type,
> -						   &rport->fpin_stats);
> -			}
> -		}
> -	}
> +	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
> +				   be32_to_cpu(li_desc->desc_len),
> +				   FC_TLV_DESC_LENGTH_FROM_SZ(*li_desc),
> +				   be32_to_cpu(li_desc->pname_count),
> +				   li_desc->pname_list, fc_li_stats_update);
>  
>  	if (fc_host->port_name == be64_to_cpu(li_desc->attached_wwpn))
>  		fc_li_stats_update(event_type, &fc_host->fpin_stats);
> @@ -827,13 +845,11 @@ static void
>  fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
>  				struct fc_tlv_desc *tlv)
>  {
> -	u8 i;
>  	struct fc_rport *rport = NULL;
>  	struct fc_rport *attach_rport = NULL;
>  	struct fc_fn_peer_congn_desc *pc_desc =
>  	    (struct fc_fn_peer_congn_desc *)tlv;
>  	u16 event_type = be16_to_cpu(pc_desc->event_type);
> -	u64 wwpn;
>  
>  	rport = fc_find_rport_by_wwpn(shost,
>  				      be64_to_cpu(pc_desc->attached_wwpn));
> @@ -844,22 +860,11 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
>  		fc_cn_stats_update(event_type, &attach_rport->fpin_stats);
>  	}
>  
> -	if (be32_to_cpu(pc_desc->pname_count) > 0) {
> -		for (i = 0;
> -		    i < be32_to_cpu(pc_desc->pname_count);
> -		    i++) {
> -			wwpn = be64_to_cpu(pc_desc->pname_list[i]);
> -			rport = fc_find_rport_by_wwpn(shost, wwpn);
> -			if (rport &&
> -			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
> -			     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
> -				if (rport == attach_rport)
> -					continue;
> -				fc_cn_stats_update(event_type,
> -						   &rport->fpin_stats);
> -			}
> -		}
> -	}
> +	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
> +				   be32_to_cpu(pc_desc->desc_len),
> +				   FC_TLV_DESC_LENGTH_FROM_SZ(*pc_desc),
> +				   be32_to_cpu(pc_desc->pname_count),
> +				   pc_desc->pname_list, fc_cn_stats_update);
>  }
>  
>  /*

