Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2E38F90
	for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 14:05:23 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BB7136
	for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 07:05:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso190158971fa.3
        for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695823519; x=1696428319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hHvUR0n4EwEOMV5of1rEk3gEaF0cxdFPl6HtMVDF9g=;
        b=rQsXaI80jmvpHELs2QWa9e93J11gYc1okeYxSekqEWMb5T70OzZL8eDWoGXfdObXOO
         VPtViHGo/dALr5X8eH8XJBRN04UjDdX7Bewfunpk/1Y7z8s5UyhUjv56S7dDz2Tz42r/
         mtDEDISBVSbA7Zu5yjNalYqYEn5GZpnYMpVat8P1yPUqFWfFmntVifiZw6vSkIKWLRET
         bGAvNyNaBVkqu+hi3STPSRGd7XLOfjTpQ0LXfHlAzLQaDUzrGW4LH0NurPXZEe5y4hUK
         Rw4NiPZXO8mQZ01XJEO2BYZgUZNZ+ZDgkgpQQRKVatMMHggEgTbVDoBZ+GBErSYK5PjY
         lsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823519; x=1696428319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hHvUR0n4EwEOMV5of1rEk3gEaF0cxdFPl6HtMVDF9g=;
        b=fz69CUuovz73SfujWhQTtQiEWlHWg2O6kclpD/aMBinGcgry0fWirpa/fYFGtYqhBI
         d2a+f4LkCuWuYIzjseBzmXKklteaMA5yvRiItcd8aJamCOrEuMhRUQA7BLwLDh2nVRz9
         RVllbCnXuY8z8hZol2YCcafM3TyoGCRpDfzxpIbE0dQPrcn15Zp8CGhVVHzlvX0C6bzW
         mFHx52janTPDUFaHccZebhbQEOuJ4E3AXNATxgMhVSd/IFS+9RNxYOkA+hoEBycRETpb
         7/EhXTYDCW8c9q2xVsmLY4HAfSwUJfgQ8s0otQxhT3PMcKBSGsfxLZN9+w7DBDpXQjaI
         /e2A==
X-Gm-Message-State: AOJu0YwOfyUhXUVDOLcXyKdXzD+l8BQ3VvVbBNYR3u3SRGeyWkoVx2Yt
	+BlSD0GlwRO59g8nYdZPA4tvAQGrMgHDtBoF+AfjNw==
X-Google-Smtp-Source: AGHT+IGyURsd0EeGPjEDXefgtQMh28AzFEh8FtUpw8FRGj6Ug6Jx5dKutZCzHJrNXhhHz7tjAg+oEEVkSLoheF/XMzY=
X-Received: by 2002:a2e:92d7:0:b0:2bc:c4af:36b7 with SMTP id
 k23-20020a2e92d7000000b002bcc4af36b7mr2178440ljh.39.1695823518581; Wed, 27
 Sep 2023 07:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921-strncpy-drivers-hwmon-acpi_power_meter-c-v3-1-307552c6ec3f@google.com>
 <9837d8dd-d802-4d5d-bca7-6e029658ba76@roeck-us.net>
In-Reply-To: <9837d8dd-d802-4d5d-bca7-6e029658ba76@roeck-us.net>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 27 Sep 2023 23:05:07 +0900
Message-ID: <CAFhGd8rY5uTh+e0U8jG94dga6Acx5R1G+MKWt=LfD5orNNca+Q@mail.gmail.com>
Subject: Re: [PATCH v3] hwmon: refactor deprecated strncpy
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 9:49=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Thu, Sep 21, 2023 at 05:41:46AM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which ha=
s
> > more obvious behavior and is less error prone.
> >
> > To avoid truncating the last byte supply `...length + 1` to
> > kmemdup_nul() as `element->string.length` does not account for the
> > trailing null as made obvious from it's definition (and associated
> > comment):
> > |       u32 length;   /* # of bytes in string, excluding trailing null =
*/
> >
> > ... this is precisely what the original kcalloc invocation did as well.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> I have multiple patches with the hwmon: prefix but no driver,
> like this one, suggesting the change is in the hwmon core,
> when in reality it is in some hwmon driver.
> I am not going to apply any of those, and I am not even going to
> look into them.

Whoops, I was using some tooling to auto-fetch prefixes and the style
of "xyz: (stuff in paren)" isn't always caught.

I will resend with a fixed subject line matching the appropriate driver.

>
> Guenter

Thanks
Justin
