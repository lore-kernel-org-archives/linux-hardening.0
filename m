Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6358851B88
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 17:40:47 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C11F1AE
	for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 10:40:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c6052422acso193275ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 29 Sep 2023 10:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696009244; x=1696614044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liTCdYbj1FVkuMGo6fO69hfA7Wsl1/IBO31+ywknd5c=;
        b=j0zMxg24klXUUNmyYuRMJS0z1XElu3mMvF50e7DfCViWICEsg1rzK8dwiJrQPLS0yq
         ia8KJnPjyLqj5hQhNYBn+yMdaN3L5oVT9igh3CJ5Cl2aXQnGCJx2/6uYBSeSu3Atde+S
         zToUBzgrDhOLZ7l4Eg42RUhsozk+vPFNA5Q76FR3v44pxZqoGHyU+Zbhzsk2SnOxWxpL
         hWLHc81GOt3/c+Wn0NxGOPPyB8YPkyCVeSt1Y3yxUJ7w5esRF/i/29BrBV8p7MvNnivr
         pG51NSenTpY4cPBG1J0TQTBFyEfZ6GpV2s+K0xUEP3cS3wIWwZKMdWEEjYbN6rYexw6J
         BAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009244; x=1696614044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liTCdYbj1FVkuMGo6fO69hfA7Wsl1/IBO31+ywknd5c=;
        b=IT5rZm5u14J4aIRdI+LGr7+slvPGctwjsyQaWYdOU2fzs2pcd8R61fP0/iXoHZ+OVm
         +SSYq5FHLHbW9MBr+vK11m6XIwDlZD7m9p/ffqFwWDe1RsdzMv98qxstpbaVpC5nhEOT
         oATB0Qrmwx0UrSvlID2oklFcxYXtH0cKAK7TdzG28HGHmxHIGxVSt1lVLJtazzdbvjP3
         UhmfdNEx9UnypixCFbX3rT2g1AJvtvE/95U2mXquiTSgEnsHYoNmcFMose6GIEuS5svA
         01L8tjSyc+MQVxStXKqNpA7lJITc9H9+bkKNCfG7jrIqCZ+Yr8yHsGnIT69UDocDhUHD
         fg/Q==
X-Gm-Message-State: AOJu0YxE1Q0kuaRceMXZiQ2lxbsihJPyi3VSidP+cwhrKaoO9L8gEXzq
	q5bzk8Qt5j0c5y41Eh68cauXKH8TSKQtSKNiqdGs7Q==
X-Google-Smtp-Source: AGHT+IG8I6uaBrpHLsp0opKXQTpmS3lePr+15GdaosXyNMvMTOYnYBMFJsjMoiUol29+4CmIxCtKX8GDmFAxRmDFoU0=
X-Received: by 2002:a17:903:41d2:b0:1c3:25c0:6dd7 with SMTP id
 u18-20020a17090341d200b001c325c06dd7mr21422ple.16.1696009243683; Fri, 29 Sep
 2023 10:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZRbwU8Qnx28gpbuO@work> <202309291027.305751B8@keescook>
In-Reply-To: <202309291027.305751B8@keescook>
From: Jann Horn <jannh@google.com>
Date: Fri, 29 Sep 2023 19:40:07 +0200
Message-ID: <CAG48ez1w_gBUF6qRmfO_wb+eYLTfrLs5csjEaPhE9iQxdqPj+Q@mail.gmail.com>
Subject: Re: [PATCH][next] media: usb: siano: Fix undefined behavior bug in
 struct smsusb_urb_t
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 7:29=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Fri, Sep 29, 2023 at 05:42:11PM +0200, Gustavo A. R. Silva wrote:
> > `struct urb` is a flexible structure, which means that it contains a
> > flexible-array member at the bottom. This could potentially lead to an
> > overwrite of the object `wq` at run-time with the contents of `urb`.
> >
> > Fix this by placing object `urb` at the end of `struct smsusb_urb_t`.
> >
> > Fixes: dd47fbd40e6e ("[media] smsusb: don't sleep while atomic")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> As Jann pointed out, it's unlikely there is a function bug here, but I
> still think it's right to make sure this is robust and clears the way
> for -Wflex-array-member-not-at-end.

But if this change makes the warning go away, that just means the
warning is implemented badly, right?

Like, before we had:

struct urb {
  ...
  struct usb_iso_packet_descriptor iso_frame_desc[];
};
struct smsusb_urb_t {
  ...
  struct urb urb; // not last element
  ...
};

whereas afterwards we have:

struct urb {
  ...
  struct usb_iso_packet_descriptor iso_frame_desc[];
};
struct smsusb_urb_t {
  ...
  struct urb urb;
};
struct smsusb_device_t {
  ...
  struct smsusb_urb_t surbs[MAX_URBS]; // array, and not last element
  ...
};

That's basically the same pattern! Except that the new version has one
more layer of indirection and there's an array involved.

And you can't address that by moving struct members around because of
the involvement of the array.
