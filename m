Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D383E473
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6py9JZy"
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3A091
	for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 15:03:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99357737980so225097166b.2
        for <linux-hardening@vger.kernel.org>; Thu, 26 Oct 2023 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698357804; x=1698962604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEmmsMUNDXrHxbfE3Ce3REr5A6wqcO3bgGi92YBCkzI=;
        b=b6py9JZyfVMrZlL9Jrva7w5VfIiGgteU73GfhFfG4sEaLJkxrbhpfZa81w21gz8eeW
         en3F3GdHCHMu7EIqMWDcUXl0qOPghFnoNDPulKM+K93DeQyP98eZpO9zlmLbF0h+oZKk
         ZPicbXWat17VSNxEdTf4WXBTxlYUelUZ65MvCdS8+M4CnwA1/yO18V+jnjFCnCw1ZR45
         4txR3ytLNXZXOa4EJzP4IQmYGxIPbQwjjlZsmNlaZu52ZFE5A9VhjxAugf7cBifOcHwz
         ES/+bXdZc5nzF29ZsVXdRJMEkfmNWUxOAyW/3epHKVbERIDuF18t0UAOt1RiP33TLzUu
         WuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698357804; x=1698962604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEmmsMUNDXrHxbfE3Ce3REr5A6wqcO3bgGi92YBCkzI=;
        b=XwqbAkv6R8sJdqisqtfpniNMXrMBzkFeolqajnJ7ceav1hc+CIIZsw9lZXB3YNpQAy
         Qy0tE02KH9UnggEiUdXY6Q2aD+IQWWICLKXDDBW21x1PL9B6AXGx4RbuMJANvaljaP9l
         eGMiWC5FXQ3d5KDqjoGn6fcvxtO1X4fzV9uNe2ms8XPMhtj9dHfjSRPgxerchEj9lA/j
         J8JXY2jhw9te33FXE+p1MNdTWIApAz5JgaT27zBue6QwAB5iO7cU9SO+wSmaZAMs2qsp
         NtoruFvVXJ1BQAKAzlFKEt5e0YMfMk5NaJKEz8HNDcoQDHRYUFrHxIrJyDFJn9kLZjzx
         jYIg==
X-Gm-Message-State: AOJu0YzYHTVvFVe3DVD7SZuTUAI003C5o/8yXbcUqe4K8rk/21qsyV4R
	C23RlNp3307BgqPWoiic80VOR0nSjyPeOA6GGXAObA==
X-Google-Smtp-Source: AGHT+IG6agKha0G/h583YdKCsY86p8qRjxzUVJVt92aAyYP3t8wQ6XoOF+pq/EnAOsxzX746Vh6W1fwNE0cooKXSZp4=
X-Received: by 2002:a17:906:6a24:b0:9c5:ea33:7bf9 with SMTP id
 qw36-20020a1709066a2400b009c5ea337bf9mr701118ejc.51.1698357804394; Thu, 26
 Oct 2023 15:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026171349.work.928-kees@kernel.org>
In-Reply-To: <20231026171349.work.928-kees@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 26 Oct 2023 15:03:11 -0700
Message-ID: <CAFhGd8p8Ako1zFrUrE62OxhqGqmDVEFi3NtT754gZP_sLAZ99w@mail.gmail.com>
Subject: Re: [RFC][PATCH] wifi: wil6210: Replace strlcat() usage with seq_buf
To: Kees Cook <keescook@chromium.org>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Max Chen <mxchen@codeaurora.org>, Yang Shen <shenyang39@huawei.com>, 
	Steven Rostedt <rostedt@goodmis.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christoph Hellwig <hch@lst.de>, Kent Overstreet <kent.overstreet@linux.dev>, Petr Mladek <pmladek@suse.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Yun Zhou <yun.zhou@windriver.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
	linux-trace-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:13=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> The use of strlcat() is fragile at best, and we'd like to remove it from
> the available string APIs in the kernel. Instead, use the safer seq_buf
> APIs.
>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Max Chen <mxchen@codeaurora.org>
> Cc: Yang Shen <shenyang39@huawei.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Yun Zhou <yun.zhou@windriver.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: linux-trace-kernel@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is mainly an example of where/how to use the ongoing seq_buf
> refactoring happening in the tracing tree:
> https://lore.kernel.org/lkml/20231026170722.work.638-kees@kernel.org/

I like it. C-strings and many of their associated apis are dodgy. This
looks like a worthwhile replacement.

I think many of my strncpy -> strscpy replacements could've easily
been something along these lines as well.

Happy to see robustness increasing in the kernel by means
of replacing sketchy C-string stuff.

> ---
>  drivers/net/wireless/ath/wil6210/wmi.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireles=
s/ath/wil6210/wmi.c
> index 6fdb77d4c59e..45b8c651b8e2 100644
> --- a/drivers/net/wireless/ath/wil6210/wmi.c
> +++ b/drivers/net/wireless/ath/wil6210/wmi.c
> @@ -3159,36 +3159,34 @@ int wmi_suspend(struct wil6210_priv *wil)
>         return rc;
>  }
>
> -static void resume_triggers2string(u32 triggers, char *string, int str_s=
ize)
> +static void resume_triggers2string(u32 triggers, struct seq_buf *s)
>  {
> -       string[0] =3D '\0';
> -
>         if (!triggers) {
> -               strlcat(string, " UNKNOWN", str_size);
> +               seq_buf_puts(s, " UNKNOWN");
>                 return;
>         }
>
>         if (triggers & WMI_RESUME_TRIGGER_HOST)
> -               strlcat(string, " HOST", str_size);
> +               seq_buf_puts(s, " HOST")
>
>         if (triggers & WMI_RESUME_TRIGGER_UCAST_RX)
> -               strlcat(string, " UCAST_RX", str_size);
> +               seq_buf_puts(s, " UCAST_RX");
>
>         if (triggers & WMI_RESUME_TRIGGER_BCAST_RX)
> -               strlcat(string, " BCAST_RX", str_size);
> +               seq_buf_puts(s, " BCAST_RX");
>
>         if (triggers & WMI_RESUME_TRIGGER_WMI_EVT)
> -               strlcat(string, " WMI_EVT", str_size);
> +               seq_buf_puts(s, " WMI_EVT");
>
>         if (triggers & WMI_RESUME_TRIGGER_DISCONNECT)
> -               strlcat(string, " DISCONNECT", str_size);
> +               seq_buf_puts(s, " DISCONNECT");
>  }
>
>  int wmi_resume(struct wil6210_priv *wil)
>  {
>         struct wil6210_vif *vif =3D ndev_to_vif(wil->main_ndev);
>         int rc;
> -       char string[100];
> +       DECLARE_SEQ_BUF(s, 100);
>         struct {
>                 struct wmi_cmd_hdr wmi;
>                 struct wmi_traffic_resume_event evt;
> @@ -3203,10 +3201,9 @@ int wmi_resume(struct wil6210_priv *wil)
>                       WIL_WAIT_FOR_SUSPEND_RESUME_COMP);
>         if (rc)
>                 return rc;
> -       resume_triggers2string(le32_to_cpu(reply.evt.resume_triggers), st=
ring,
> -                              sizeof(string));
> +       resume_triggers2string(le32_to_cpu(reply.evt.resume_triggers), s)=
;
>         wil_dbg_pm(wil, "device resume %s, resume triggers:%s (0x%x)\n",
> -                  reply.evt.status ? "failed" : "passed", string,
> +                  reply.evt.status ? "failed" : "passed", seq_buf_cstr(s=
),
>                    le32_to_cpu(reply.evt.resume_triggers));
>
>         return reply.evt.status;
> --
> 2.34.1
>

Thanks
Justin
