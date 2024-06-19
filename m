Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1656182B9;
	Wed, 19 Jun 2024 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808204; cv=none; b=YmxoRBGHsgnJX+Lg9iqJHp30J+wBnEjyGGY2o+o2frNOEozrlgAoA30TagddQgk82HSo4wh1c6TM2h5GjgUPMg3hF8JufPsftEY1aTwWwfrtnS6hvarzxR1G2ml98VYKcjLuQtgRlnYXhcrQKjucClEaqCrn+g2NiKkW9n7dtlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808204; c=relaxed/simple;
	bh=LJPht4Ub9bY7nUd850dflo7eqAY3XAP1LS0KzfrQ+hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9rLRdItGvD6fot8WRp3fClw1mJHwzHLAnn/OZo4rb9IWMRKmIkBPngXOseK3FQ0vr0uXYuZRaMyJq7k8FYRAvdiImwJHkVfWHIceWjxy6tet7z1XaMDOuyrcmjGyvacbOmZp358R3oWu4X3n5Fnz2CCaMK7hAT8cnGvTnS3aaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBSJQoiC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBSJQoiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C63C2BBFC;
	Wed, 19 Jun 2024 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718808203;
	bh=LJPht4Ub9bY7nUd850dflo7eqAY3XAP1LS0KzfrQ+hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBSJQoiC5fdPJmItV3cVhKlpWdUc3K7JOlVBHV7fUqf5OdWhySZB9+gETipZrJLwk
	 ItZEYjAmlfSC70N56f8rM5k8BCcZyW9ZQAeLLu2cnGxVhKEExwe6AV4xbMOXyQMt6X
	 huXm0nxO5de0ggr2Takr5J3aguim3l0YzFk5CrcKVEsJ23dv1r2o0YTTAM2Pik0I/F
	 ecItaNIQpln/7YpAOdkK+4uIxstctIk1H4/Q6f5V8hPZzjYq1PM6djyVtt0Qg1zB9V
	 7t2Tr20szBZMwiMlx4rqhX3T2epyQ9aLNZlvrR9uSemvd3UkhmbB76PHdX2a4TYiJc
	 kA3hgh8TwoVSw==
Date: Wed, 19 Jun 2024 07:43:20 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] USB: serial: garmin_gps: annotate struct garmin_packet
 with __counted_by
Message-ID: <20240619144320.GA2091442@thelio-3990X>
References: <20240619-garmin_gps_counted_by-v1-1-d8d816f085d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-garmin_gps_counted_by-v1-1-d8d816f085d9@gmail.com>

On Wed, Jun 19, 2024 at 11:40:57AM +0200, Javier Carrasco wrote:
> Use the __counted_by compiler attribute for the data[] flexible array member
> to improve the results of array bound sanitizers.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> The size is assigned before the first reference to the flexible array
> (see pkt_add()), which allows for a straightforward annotation without
> further modifications.

Agreed, this seems like a reasonable patch in and of itself that should
work:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

It might also make sense to change the pkt allocation to use
struct_size() instead of open coding it?

diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index 670e942fdaaa..04946c1cbf6f 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -267,8 +267,7 @@ static int pkt_add(struct garmin_data *garmin_data_p,
 
 	/* process only packets containing data ... */
 	if (data_length) {
-		pkt = kmalloc(sizeof(struct garmin_packet)+data_length,
-								GFP_ATOMIC);
+		pkt = kmalloc(struct_size(pkt, data, data_length), GFP_ATOMIC);
 		if (!pkt)
 			return 0;
 

> ---
>  drivers/usb/serial/garmin_gps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
> index 670e942fdaaa..57df6ad183ff 100644
> --- a/drivers/usb/serial/garmin_gps.c
> +++ b/drivers/usb/serial/garmin_gps.c
> @@ -104,7 +104,7 @@ struct garmin_packet {
>  	int               seq;
>  	/* the real size of the data array, always > 0 */
>  	int               size;
> -	__u8              data[];
> +	__u8              data[] __counted_by(size);
>  };
>  
>  /* structure used to keep the current state of the driver */
> 
> ---
> base-commit: 0c52056d9f77508cb6d4d68d3fc91c6c08ec71af
> change-id: 20240619-garmin_gps_counted_by-376545960353
> 
> Best regards,
> -- 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
