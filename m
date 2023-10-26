Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3DE3B287
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UuAxFZ8r"
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B53C1
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:44:30 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so1122005b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698342270; x=1698947070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jqXzjoliREKB9p4xvOcB3bDuTodJi0Be8+f3YEh/Sg=;
        b=UuAxFZ8rojf9RiVgjodvcnx9tJZQKRPhLFg/9DS/kB0Kk29oF8RLPtNvU94j8RKkHP
         YsO8caU4GwFUCqRTV+IPIMelJY1qjMryKVZw8tkr82N6mU4KbkUEvWR5KmqciSm1inU6
         4beguz8oGtlSvj2SRzcGWpjP5yo+g7Lng7YmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698342270; x=1698947070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jqXzjoliREKB9p4xvOcB3bDuTodJi0Be8+f3YEh/Sg=;
        b=oZqTdOPuq+CO/YO4Sux3AlUvI25GzlYp79MzqX75kAtYxOhmotsrYYsAIl4wxLv7EQ
         8srg0Y/gIBhTbBbtMpJffb8P0a9GT/iclawaRoYN8VBlBMiw8/pHvXG4d20RUam8QNMi
         9BLeHDrh4tbaeWTnZF6s3o+U72O5/GYw46ZcNw1LABL7Cp3pGM8rsj22Pk0wOn7CBdpJ
         9VCqF/MJmpt+RrJuuC4Ev/tz4bkjfj9SMiDe375xvqeyuEql9wgNhPd0IS6tYtue+yR+
         GqTUBul35yqHAilt++JFf/oa4X/5P43qh4NgUl2jMBkERuo07621gtm4OnlGK/mdwWVi
         695Q==
X-Gm-Message-State: AOJu0YzqCNQE9u2ARm62+xfjF4jgDg4VkQQletb9TnVfcvFKZtGUXenO
	AgaLwoDL1RMlz9GjJsQqhI8zVA==
X-Google-Smtp-Source: AGHT+IFIn1TkvOQua4DcmGtNXg1tdDKwF/PYGg46B4rhYe8Xi52z8+DAf60V+s3DGKZUgN6hKkhyNw==
X-Received: by 2002:a05:6a00:2307:b0:68e:380c:6b15 with SMTP id h7-20020a056a00230700b0068e380c6b15mr200952pfh.26.1698342269673;
        Thu, 26 Oct 2023 10:44:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7952f000000b006934e7ceb79sm11469116pfp.32.2023.10.26.10.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:44:29 -0700 (PDT)
Date: Thu, 26 Oct 2023 10:44:28 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	storagedev@microchip.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: hpsa: replace deprecated strncpy with
 strscpy/kmemdup_nul
Message-ID: <202310261025.2FE91B6B5B@keescook>
References: <20231026-strncpy-drivers-scsi-hpsa-c-v1-1-75519d7a191b@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-strncpy-drivers-scsi-hpsa-c-v1-1-75519d7a191b@google.com>

On Thu, Oct 26, 2023 at 01:47:32AM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This whole process of 1) determining smaller length so we don't overread
> the buffer and 2) manually NUL-terminating our buffer so we can use in
> string APIs is handled implicitly by strscpy().
> 
> Therefore, a suitable replacement is `strscpy` [2] due to the fact that
> it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> For the last two strncpy() use cases in init_driver_version(), we can
> actually drop this function entirely.
> 
> Firstly, we are kmalloc()'ing driver_version. Then, we are calling
> init_driver_version() which memset's it to 0 followed by a strncpy().
> This pattern of 1) allocating memory for a string, 2) setting all bytes
> to NUL, 3) copy bytes from another string + ensure NUL-padded
> destination is just an open-coded kmemdup_nul().
> 
> The last case involves swapping kmalloc_array() for kcalloc() to give us
> a zero-filled two-element array for both old_driver_version and
> driver_version without needing the memset from init_driver_version().
> 
> Now this code is easier to read and less fragile (no more ... - 1's) or
> min length checks and now we have guaranteed NUL-termination everywhere!
> 
> Although perhaps there should be a macro for:
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/scsi/hpsa.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index af18d20f3079..3376d4614fe5 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -452,16 +452,15 @@ static ssize_t host_store_hp_ssd_smart_path_status(struct device *dev,
>  					 struct device_attribute *attr,
>  					 const char *buf, size_t count)
>  {
> -	int status, len;
> +	int status;
>  	struct ctlr_info *h;
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	char tmpbuf[10];
>  
>  	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>  		return -EACCES;
> -	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
> -	strncpy(tmpbuf, buf, len);
> -	tmpbuf[len] = '\0';
> +	strscpy(tmpbuf, buf, count);

This is wrong -- "count" isn't the size of tmpbuf -- it's the size of
the source, i.e.  strlen(buf).

> +
>  	if (sscanf(tmpbuf, "%d", &status) != 1)
>  		return -EINVAL;

And this is immediately using the tmpbuf for getting an int. All of this
should be replaced by kstrtoint().

>  	h = shost_to_hba(shost);
> @@ -476,16 +475,15 @@ static ssize_t host_store_raid_offload_debug(struct device *dev,
>  					 struct device_attribute *attr,
>  					 const char *buf, size_t count)
>  {
> -	int debug_level, len;
> +	int debug_level;
>  	struct ctlr_info *h;
>  	struct Scsi_Host *shost = class_to_shost(dev);
>  	char tmpbuf[10];
>  
>  	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>  		return -EACCES;
> -	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
> -	strncpy(tmpbuf, buf, len);
> -	tmpbuf[len] = '\0';
> +	strscpy(tmpbuf, buf, count);
> +
>  	if (sscanf(tmpbuf, "%d", &debug_level) != 1)
>  		return -EINVAL;

Same thing here.

>  	if (debug_level < 0)
> @@ -7234,24 +7232,19 @@ static int hpsa_controller_hard_reset(struct pci_dev *pdev,
>  	return 0;
>  }
>  
> -static void init_driver_version(char *driver_version, int len)
> -{
> -	memset(driver_version, 0, len);
> -	strncpy(driver_version, HPSA " " HPSA_DRIVER_VERSION, len - 1);
> -}
> -
>  static int write_driver_ver_to_cfgtable(struct CfgTable __iomem *cfgtable)
>  {
>  	char *driver_version;
>  	int i, size = sizeof(cfgtable->driver_version);
>  
> -	driver_version = kmalloc(size, GFP_KERNEL);
> +	driver_version = kmemdup_nul(HPSA " " HPSA_DRIVER_VERSION, size,
> +				     GFP_KERNEL);

"size" isn't the length of the string here, so this results in an
over-read from the .data segment:

drivers/scsi/hpsa.c:#define HPSA "hpsa"
drivers/scsi/hpsa.c:#define HPSA_DRIVER_VERSION "3.4.20-200"

strlen(HSPA " " HPSA_DRIVER_VERSION) == 15 (16 with %NUL terminator)

sizeof(cfgtable->driver_version) == 32:

struct CfgTable {
	...
        u8              driver_version[32];

>  	if (!driver_version)
>  		return -ENOMEM;
>  
> -	init_driver_version(driver_version, size);
>  	for (i = 0; i < size; i++)
>  		writeb(driver_version[i], &cfgtable->driver_version[i]);

And then this will write garbage out to the driver for the 16 bytes
following the string... :(

Also, this thing is doing an alloc/free for a tiny string. That can just
be on the stack:

	char driver_version[sizeof(cfgtable->driver_version)] = HPSA " " HPSA_DRIVER_VERSION;

No alloc/free, no strscpy, easy easy. (Since the string is explicitly
sized, the remaining space will be zero-initialized.)


> +
>  	kfree(driver_version);
>  	return 0;
>  }
> @@ -7271,7 +7264,7 @@ static int controller_reset_failed(struct CfgTable __iomem *cfgtable)
>  	char *driver_ver, *old_driver_ver;
>  	int rc, size = sizeof(cfgtable->driver_version);
>  
> -	old_driver_ver = kmalloc_array(2, size, GFP_KERNEL);
> +	old_driver_ver = kcalloc(2, size, GFP_KERNEL);
>  	if (!old_driver_ver)
>  		return -ENOMEM;
>  	driver_ver = old_driver_ver + size;
> @@ -7279,7 +7272,7 @@ static int controller_reset_failed(struct CfgTable __iomem *cfgtable)
>  	/* After a reset, the 32 bytes of "driver version" in the cfgtable
>  	 * should have been changed, otherwise we know the reset failed.
>  	 */
> -	init_driver_version(old_driver_ver, size);
> +	strscpy(old_driver_ver, HPSA " " HPSA_DRIVER_VERSION, size);
>  	read_driver_ver_from_cfgtable(cfgtable, driver_ver);
>  	rc = !memcmp(driver_ver, old_driver_ver, size);
>  	kfree(old_driver_ver);

This function is also wild -- it's allocating 2 strings (but at the same
time, and using offsets to get to them), and again -- why? Just use the
stack for 64 bytes:

	char driver_ver[sizeof(cfgtable->driver_version)] = "";
	char old_driver_ver[sizeof(cfgtable->driver_version)] = HPSA " " HPSA_DRIVER_VERSION;

-Kees

-- 
Kees Cook
